

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="sendMail">
            <label for="to">To</label>
            <input type="email" name="to" id="to">
            
            <label for="subject">Subject</label>
            <input type="text" name="subject" id="subject">
            
            <label for="msg">Message</label>
            <input type="text-area" rows="5" cols="10" name="msg" id="msg">
            
            
            
            
        </form>
    </body>
</html>
