#!/bin/bash
# Validate mapping_rules.yaml structure and cross-reference .srv files.
#
# This test script is registered as a CTest (via add_test in CMakeLists.txt).
# It can also be run standalone:
#   ./test/validate_mapping_rules.sh

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MAPPING_FILE="${REPO_ROOT}/mapping_rules.yaml"
SRV_DIR="${REPO_ROOT}/srv"

# ---------------------------------------------------------------------------
# Helper: extract a YAML scalar value for a given key from the mapping file.
# This is intentionally simple — mapping_rules.yaml uses a flat indented-block
# structure with single-quoted string values.
# ---------------------------------------------------------------------------
extract_field() {
  field_name="$1"
  # Match lines like: "  ros2_service_name: 'AddTwoInts'"
  # Capture the quoted value without quotes.
  # We require at least one leading space so we don't match the key inside a
  # comment or the wrong nesting level.
  sed -n "s/^[[:space:]]\{1,\}${field_name}:[[:space:]]*'\([^']*\)'.*/\1/p" \
    "${MAPPING_FILE}"
}

# ---------------------------------------------------------------------------
# Phase 1 — structural validation: every mapping entry must define the four
#            required fields, and no extra fields should appear.
# ---------------------------------------------------------------------------
ALLOWED_FIELDS="ros1_package_name ros1_service_name ros2_package_name ros2_service_name"

# Collect every indented key (lines matching "  <key>:") and verify they are
# all in the allowed set.
extra_fields=0
while IFS= read -r line; do
  key=$(echo "${line}" | sed -n 's/^[[:space:]]\{1,\}\([a-zA-Z0-9_]*\):.*/\1/p')
  if [ -n "${key}" ]; then
    allowed=0
    for af in ${ALLOWED_FIELDS}; do
      if [ "${key}" = "${af}" ]; then
        allowed=1
        break
      fi
    done
    if [ "${allowed}" -eq 0 ]; then
      echo "ERROR: unknown field '${key}' in mapping_rules.yaml"
      extra_fields=$((extra_fields + 1))
    fi
  fi
done < "${MAPPING_FILE}"

# Count mapping entries by counting top-level list markers ("-" at column 0).
entry_count=$(grep -c '^-$' "${MAPPING_FILE}" 2>/dev/null || echo 0)

if [ "${entry_count}" -eq 0 ]; then
  echo "ERROR: no mapping entries found in mapping_rules.yaml"
  exit 1
fi

errors=0

# Verify each required field appears at least entry_count times.
for field in ${ALLOWED_FIELDS}; do
  count=$(grep -c "${field}:" "${MAPPING_FILE}" 2>/dev/null || echo 0)
  if [ "${count}" -lt "${entry_count}" ]; then
    echo "ERROR: required field '${field}' appears ${count} time(s) but" \
      "${entry_count} mapping entries are present"
    errors=$((errors + 1))
  fi
done

errors=$((errors + extra_fields))

# ---------------------------------------------------------------------------
# Phase 2 — cross-reference: every ros2_service_name must match a .srv file
#            defined in this package.
# ---------------------------------------------------------------------------
ros2_svc_count=0
for name in $(extract_field "ros2_service_name"); do
  ros2_svc_count=$((ros2_svc_count + 1))
  srv_file="${SRV_DIR}/${name}.srv"
  if [ ! -f "${srv_file}" ]; then
    echo "ERROR: ros2_service_name '${name}' does not match any .srv file" \
      "in srv/ (expected ${srv_file})"
    errors=$((errors + 1))
  fi
done

# ---------------------------------------------------------------------------
# Phase 3 — ROS 1 field plausibility: required fields must be non-empty.
# ---------------------------------------------------------------------------
check_non_empty() {
  field_label="$1"
  field_name="$2"
  for val in $(extract_field "${field_name}"); do
    if [ -z "${val}" ]; then
      echo "ERROR: ${field_label} ('${field_name}') is empty in an entry"
      errors=$((errors + 1))
    fi
  done
}

check_non_empty "ros1_package_name" "ros1_package_name"
check_non_empty "ros1_service_name" "ros1_service_name"
check_non_empty "ros2_package_name" "ros2_package_name"

# ---------------------------------------------------------------------------
# Phase 4 — verify ros2_package_name is this package (example_interfaces).
# ---------------------------------------------------------------------------
for pkg in $(extract_field "ros2_package_name"); do
  if [ "${pkg}" != "example_interfaces" ]; then
    echo "ERROR: ros2_package_name '${pkg}' is not 'example_interfaces'"
    errors=$((errors + 1))
  fi
done

# ---------------------------------------------------------------------------
# Report
# ---------------------------------------------------------------------------
if [ "${errors}" -gt 0 ]; then
  echo ""
  echo "mapping_rules.yaml validation FAILED with ${errors} error(s)"
  exit 1
fi

echo "mapping_rules.yaml validation PASSED (${entry_count} entries," \
  "${ros2_svc_count} ros2_service_name references checked)"
