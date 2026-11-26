<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Murach's Java Servlets and JSP</title>
  <link rel="stylesheet" href="styles/style.css"/>
</head>

<body>
<h1>Thanks for joining our email list</h1>

<p>Here is the information that you entered:</p>

<label>Email:</label>
<span>${sessionScope.user.email}</span><br>
<label>First Name:</label>
<span>${sessionScope.user.firstName}</span><br>
<label>Last Name:</label>
<span>${sessionScope.user.lastName}</span><br>

<p>To enter another email address, click on the Back
  button in your browser or the Return button shown
  below.</p>

<form action="emailList" method="post">
  <input type="hidden" name="action" value="join">
  <input type="submit" value="Return">
</form>

<hr>
<p>Current date: ${requestScope.currentDate}</p>

<p>The first two users in the list are:</p>
<p>User 1: ${users[0].firstName} ${users[0].lastName} - ${users[0].email}</p>
<p>User 2: ${users[1].firstName} ${users[1].lastName} - ${users[1].email}</p>

<p>Customer service email: ${initParam.custServeEmail}</p>

</body>
</html>
