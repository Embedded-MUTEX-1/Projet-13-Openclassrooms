import { Component, OnInit, ViewChild, ViewContainerRef } from '@angular/core';
import { Router } from '@angular/router';
import { ChatServiceService } from 'src/app/services/chat-service.service';
import { MessageComponent } from '../message/message.component';

@Component({
  selector: 'app-thread',
  templateUrl: './thread.component.html',
  styleUrls: ['./thread.component.css']
})
export class ThreadComponent implements OnInit {
  @ViewChild('container', { read: ViewContainerRef }) container: any;
  @ViewChild('input') input: any;

  constructor(private chatService: ChatServiceService, private routerService: Router) { }

  ngOnInit(): void {
    this.chatService.getNewMessage$().subscribe((message) => {
      const messageComponentRef = this.container.createComponent(MessageComponent);

      if(this.routerService.url.includes('support')) {
        messageComponentRef.setInput('user', 'Client');
      } else {
        messageComponentRef.setInput('user', 'Support');
      }

      messageComponentRef.setInput('message', message);
      messageComponentRef.setInput('type', 'reply');

      this.container.element.nativeElement.appendChild(messageComponentRef.location.nativeElement);
    });
  }

  sendMessage() {
    const message = this.input.nativeElement.value;
    this.chatService.sendMessage(message);
    this.input.nativeElement.value = '';

    const messageComponentRef = this.container.createComponent(MessageComponent);

    messageComponentRef.setInput('message', message);
    messageComponentRef.setInput('user', 'You');
    messageComponentRef.setInput('type', 'message');

    this.container.element.nativeElement.appendChild(messageComponentRef.location.nativeElement);
  }
}
