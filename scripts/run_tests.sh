#!/bin/bash
set -e

# Ensure we are always at the project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

echo "=== Lunite Compiler Test Suite ==="
echo "Running from: $PROJECT_ROOT"

# Build the compiler first
echo "Building compiler..."
cd compiler_rust
cargo build --quiet
cd "$PROJECT_ROOT"

LUNITE="./compiler_rust/target/debug/lunite_lang"

run_test() {
    TEST_FILE="$1"
    echo "Running $TEST_FILE..."
    
    if [ ! -f "$TEST_FILE" ]; then
        echo "Skipping $TEST_FILE (file not found)"
        return
    fi

    stem=$(basename "$TEST_FILE" .lun)
    dir=$(dirname "$TEST_FILE")
    
    # Run build
    if ! $LUNITE build "$TEST_FILE"; then
        echo "Build failed for $TEST_FILE"
        exit 1
    fi
    
    # Execute binary
    BINARY="$dir/$stem"
    if [ -f "$BINARY" ]; then
        "$BINARY"
        # Cleanup binary after run to keep folder clean
        rm "$BINARY"
    else
        echo "Error: Binary not produced for $TEST_FILE"
        exit 1
    fi
    echo "---------------------------"
}

# Original tests
run_test "tests/test_memory_arena.lun"
run_test "tests/test_dynamic_list.lun"
run_test "tests/test_concurrency_prime.lun"
run_test "tests/test_string_unicode.lun"
run_test "tests/test_lexer_port.lun"

# New moved tests (optional, added just in case)
run_test "tests/test_hello.lun"

echo "All tests passed successfully!"
