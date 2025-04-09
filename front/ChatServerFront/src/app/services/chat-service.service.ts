import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ChatServiceService {
  private newMessage$ = new Subject<string>();
  private ws: WebSocket;

  constructor() {
    this.ws = new WebSocket('ws://localhost:5000/chat');
    this.ws.onopen = () => {
      console.log('Connected to WebSocket server');
    };

    this.ws.onmessage = (event) => {
      this.newMessage$.next(event.data);
    };
  }

  sendMessage(message: string) {
    if (this.ws.readyState === WebSocket.OPEN) {
      this.ws.send(message);
      console.log('Message sent:', message);
    }
  }

  getNewMessage$() {
    return this.newMessage$;
  }
}
