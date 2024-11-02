import socket
import time

def main():
    while True:
        try:
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.connect(('go_server', 5000))
            for i in range(5):
                message = f"Very important message {i} from Python"
                sock.send(message.encode())
                print(f"Sent: {message}")
                time.sleep(1)
            sock.close()
            time.sleep(5)
            
        except Exception as e:
            print(f"Error: {e}")
            time.sleep(5)

if __name__ == "__main__":
    time.sleep(5)
    main()

