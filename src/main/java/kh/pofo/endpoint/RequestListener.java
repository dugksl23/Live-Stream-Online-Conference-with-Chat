package kh.pofo.endpoint;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;

@WebListener
public class RequestListener implements ServletRequestListener {
//client의 요청과 함께 httpServletRequest가 발생된다. 이때 lisner 객체를 통해
// 제일 먼저 이 클래스가 작동되도록 하며, 아래의 initialized 메소드를 통해서
// session의 값을 가져오도록 한다.
    @Override
    public void requestDestroyed(ServletRequestEvent sre) {
        // TODO Auto-generated method stub

    }

    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        ((HttpServletRequest) sre.getServletRequest()).getSession();
    }

}