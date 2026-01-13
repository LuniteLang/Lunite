const fs = require('fs');

async function run() {
    const wasmBuffer = fs.readFileSync('test_wasm.wasm');
    
    // Cung cấp các hàm "ngoại bang" (imports) cho WASM
    const importObject = {
        env: {
            // Lunite mong đợi hàm này để in số nguyên
            lunite_print_int: (n) => console.log(">>> Lunite WASM Output:", n),
            // Dummy cho khởi tạo tham số
            lunite_init_args: (argc, argv) => { /* console.log("WASM: init_args called"); */ }
        }
    };

    try {
        const { instance } = await WebAssembly.instantiate(wasmBuffer, importObject);
        
        console.log("WASM Module Loaded successfully!");
        
        // Tìm hàm main để chạy
        if (instance.exports.main) {
            console.log("Executing main()...");
            instance.exports.main();
        } else {
            console.error("Error: main() function not found in exports!");
            console.log("Available exports:", Object.keys(instance.exports));
        }
    } catch (err) {
        console.error("Crash rồi sếp ơi:", err);
    }
}

run();
