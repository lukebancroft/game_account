<html>
<head>
    <asset:stylesheet src="login.css"/>
    <meta name="layout" content="${gspLayout ?: 'main'}"/>
    <title><g:message code='springSecurity.login.title'/></title>
</head>

<body>
<div class="wrapper fadeInDown">
    <div id="formContent">
        <g:if test='${flash.message}'>
            <div class="login_message">${flash.message}</div>
        </g:if>

        <div class="fadeIn first">
            <asset:image src="login_img.svg" id="icon" alt="Login image"/>
        </div>

        <form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" class="cssform" autocomplete="off">
            <input type="text" class="fadeIn second" name="${usernameParameter ?: 'username'}" id="username"  placeholder="username"/>
            <input type="password" class="fadeIn third" name="${passwordParameter ?: 'password'}" id="password"  placeholder="password"/>
            <p id="remember_me_holder">
                <input type="checkbox" class="chk" name="${rememberMeParameter ?: 'remember-me'}" id="remember_me" <g:if test='${hasCookie}'>checked="checked"</g:if>/>
                <label for="remember_me"><g:message code='springSecurity.login.remember.me.label'/></label>
            </p>
            <input type="submit" id="fadeIn fourth" value="${message(code: 'springSecurity.login.button')}"/>
        </form>

    </div>
</div>

<script>
    (function() {
        document.forms['loginForm'].elements['${usernameParameter ?: 'username'}'].focus();
    })();
</script>
</body>
</html>
