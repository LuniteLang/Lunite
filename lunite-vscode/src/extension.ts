import * as path from 'path';
import { workspace, ExtensionContext } from 'vscode';
import {
  LanguageClient,
  LanguageClientOptions,
  ServerOptions,
} from 'vscode-languageclient/node';

let client: LanguageClient;

export function activate(context: ExtensionContext) {
  // Sếp nhớ add folder chứa lunite_lang vào PATH hoặc sửa đường dẫn tuyệt đối ở đây
  // Ví dụ: /home/kali/Lunite/Lunite/lunite_lang/compiler_rust/target/release/lunite_lang
  const serverExecutable = 'lunite_lang'; 

  const serverOptions: ServerOptions = {
    run: { command: serverExecutable, args: ['lsp'] },
    debug: { command: serverExecutable, args: ['lsp'] }
  };

  const clientOptions: LanguageClientOptions = {
    documentSelector: [{ scheme: 'file', language: 'lunite' }],
    synchronize: {
      fileEvents: workspace.createFileSystemWatcher('**/*.lun')
    }
  };

  client = new LanguageClient(
    'luniteLsp',
    'Lunite Language Server',
    serverOptions,
    clientOptions
  );

  client.start();
}

export function deactivate(): Thenable<void> | undefined {
  if (!client) {
    return undefined;
  }
  return client.stop();
}
