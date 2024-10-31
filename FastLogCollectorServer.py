# /root/FastLogCollectorServer.py

from http.server import HTTPServer, BaseHTTPRequestHandler
import threading

lock = threading.Lock()

class SimpleHandler(BaseHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        self.file = open('received_logs.txt', 'ab')
        super().__init__(*args, **kwargs)

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        
        with lock:
            self.file.write(post_data + b'\n')
            self.file.flush()
        
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Log received")

def run(server_class=HTTPServer, handler_class=SimpleHandler, port=8080):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting server on port {port}...')
    httpd.serve_forever()

if __name__ == '__main__':
    run()
