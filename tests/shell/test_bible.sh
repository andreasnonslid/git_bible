#!/bin/bash

# Test Results
PASS=0
FAIL=0
PASS_LIST=()
FAIL_LIST=()

# Utility function to check conditions
assert() {
    local command="$1"

    if eval "$command"; then
        echo "[PASS] $command"
        PASS=$((PASS + 1))
        PASS_LIST+=("$command")
    else
        echo "[FAIL] $command"
        FAIL=$((FAIL + 1))
        FAIL_LIST+=("$command")
    fi
}

test_load_script() {
    assert "source ./shell_git_bible.sh >/dev/null 2>&1"
}

test_config_set() {
    assert "[ \"$(git config --global user.name)\" = 'Andreas Nonslid Håvardsen' ]"
    assert "[ \"$(git config --global user.email)\" = 'andreas.nonshaav@hotmail.com' ]"
}

# Run Tests
echo "Running Bash Tests..."
test_load_script
test_config_set

# Final Summary
echo
echo "Test Summary:"

# List failed tests, if any
if [[ ${#FAIL_LIST[@]} -gt 0 ]]; then
    echo "  Failed Tests:"
    for cmd in "${FAIL_LIST[@]}"; do
        echo "    - $cmd"
    done
else
    echo "  All tests passed."
fi

# List passed tests
if [[ ${#PASS_LIST[@]} -gt 0 ]]; then
    echo "  Passed Tests:"
    for cmd in "${PASS_LIST[@]}"; do
        echo "    - $cmd"
    done
fi

echo
echo "  Passed: $PASS"
echo "  Failed: $FAIL"

# Exit with status 1 if any test failed
[[ $FAIL -eq 0 ]]
