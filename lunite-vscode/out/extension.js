"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deactivate = exports.activate = void 0;
const vscode_1 = require("vscode");
const node_1 = require("vscode-languageclient/node");
let client;
function activate(context) {
    // Sếp nhớ add folder chứa lunite_lang vào PATH hoặc sửa đường dẫn tuyệt đối ở đây
    // Ví dụ: /home/kali/Lunite/Lunite/lunite_lang/compiler_rust/target/release/lunite_lang
    const serverExecutable = 'lunite_lang';
    const serverOptions = {
        run: { command: serverExecutable, args: ['lsp'] },
        debug: { command: serverExecutable, args: ['lsp'] }
    };
    const clientOptions = {
        documentSelector: [{ scheme: 'file', language: 'lunite' }],
        synchronize: {
            fileEvents: vscode_1.workspace.createFileSystemWatcher('**/*.lun')
        }
    };
    client = new node_1.LanguageClient('luniteLsp', 'Lunite Language Server', serverOptions, clientOptions);
    client.start();
}
exports.activate = activate;
function deactivate() {
    if (!client) {
        return undefined;
    }
    return client.stop();
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map