package guestbook;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

/**
 * This class is created only for the purpose of demonstrating unit testing of the
 * {@link GuestbookServlet} class. Only those methods have meaningful implementation
 * which are used in the unit test.
 * 
 * Feel free to change this class or replace it using other ways for testing
 * {@link HttpServlet}s, e.g. Spring MVC Test or Mockito to suit your needs.
 *
 */
public class MockHttpServletResponse implements HttpServletResponse {

  private String contentType;
  private StringWriter writerContent = new StringWriter();
  private PrintWriter writer = new PrintWriter(writerContent);

  @Override
  public void setContentType(String contentType) {
    this.contentType = contentType;
  }

  @Override
  public String getContentType() {
    return contentType;
  }

  @Override
  public PrintWriter getWriter() throws IOException {
    return writer;
  }

  public StringWriter getWriterContent() {
    return writerContent;
  }
  
  // anything below is the default generated implementation
  
  @Override
  public void flushBuffer() throws IOException {
  }

  @Override
  public int getBufferSize() {
    return 0;
  }

  @Override
  public String getCharacterEncoding() {
    return null;
  }

  @Override
  public Locale getLocale() {
    return null;
  }

  @Override
  public ServletOutputStream getOutputStream() throws IOException {
    return null;
  }

  @Override
  public boolean isCommitted() {
    return false;
  }

  @Override
  public void reset() {
  }

  @Override
  public void resetBuffer() {
  }

  @Override
  public void setBufferSize(int arg0) {
  }

  @Override
  public void setCharacterEncoding(String arg0) {
  }

  @Override
  public void setContentLength(int arg0) {
  }

  @Override
  public void setLocale(Locale arg0) {
  }

  @Override
  public void addCookie(Cookie arg0) {
  }

  @Override
  public void addDateHeader(String arg0, long arg1) {
  }

  @Override
  public void addHeader(String arg0, String arg1) {
  }

  @Override
  public void addIntHeader(String arg0, int arg1) {
  }

  @Override
  public boolean containsHeader(String arg0) {
    return false;
  }

  @Override
  public String encodeRedirectURL(String arg0) {
    return null;
  }

  @Override
  public String encodeRedirectUrl(String arg0) {
    return null;
  }

  @Override
  public String encodeURL(String arg0) {
    return null;
  }

  @Override
  public String encodeUrl(String arg0) {
    return null;
  }

  @Override
  public void sendError(int arg0) throws IOException {
  }

  @Override
  public void sendError(int arg0, String arg1) throws IOException {
  }

  @Override
  public void sendRedirect(String arg0) throws IOException {
  }

  @Override
  public void setDateHeader(String arg0, long arg1) {
  }

  @Override
  public void setHeader(String arg0, String arg1) {
  }

  @Override
  public void setIntHeader(String arg0, int arg1) {
  }

  @Override
  public void setStatus(int arg0) {
  }

  @Override
  public void setStatus(int arg0, String arg1) {
  }

}
