package fr.yourcaryourway.app.websockethandlers;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

@Component
public class ChatHandler extends TextWebSocketHandler {
    private final List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        InetSocketAddress clientAddress = session.getRemoteAddress();

        System.out.printf("Accepted connection from: %s:%s\n", clientAddress.getAddress().getHostAddress(), clientAddress.getPort());

        sessions.add(session);
    }

    @Override
    public void handleTextMessage(WebSocketSession currentSession, TextMessage message) throws IOException {
        int sessionIdx = sessions.indexOf(currentSession);

        System.out.printf("Received message from: %s\n", currentSession.getRemoteAddress().getAddress().getHostAddress());

        if(sessionIdx >= 0 && sessions.size() >= 2) {
            sessions.get(sessionIdx == 1 ? 0 : 1).sendMessage(message);

            System.out.printf("Message forwarded: %s\n", message.getPayload());
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) {
        sessions.remove(session);
        System.out.printf("Connection closed for: %s\n", session.getRemoteAddress().getAddress().getHostAddress());
    }

}
