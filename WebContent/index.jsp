<%@page import="java.util.Map"%>
<%@page import="chiselgui.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="ISO-8859-1">
<title>Chisel</title>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$('button')
								.on(
										'click tap',
										function() {
											if ($(this).data("value3") === 'TaskType') {
												$
														.ajax({
															type : "get",
															crossDomain : true,
															url : "http://localhost:8080/chisel/admin/util/config/tasktype/en_di/"
																	+ $(this)
																			.data(
																					"value1")
																	+ "/"
																	+ $(this)
																			.data(
																					"value2"),
															success : function(
																	msg) {

															}
														});
											}
											if ($(this).data("value3") === 'RunTime') {
												$
														.ajax({
															type : "get",
															crossDomain : true,
															url : "http://localhost:8080/chisel/admin/util/config/runtime/undeploy/"
																	+ $(this)
																			.data(
																					"value1"),
															success : function(
																	msg) {

															}
														});
											}
											if ($(this).data("value3") === 'addTaskType') {
												var newTaskType = document
														.getElementById("newTaskType").value;
												var newClassName = document
														.getElementById("newClassName").value;
												var newComment = document
														.getElementById("newComment").value;
												var newIsEnabled = document
														.getElementById("newIsEnabled").value;
												console.log(newTaskType)
												console.log(newClassName)
												console.log(newComment)
												console.log(newIsEnabled)
												console.log('done')
												if ($(this).data("value2") === 'add') {
													$
															.ajax({
																type : "post",
																crossDomain : true,
																headers : {
																	'tasktype' : newTaskType,
																	'classname' : newClassName,
																	'comment' : newComment,
																	'isenabled' : newIsEnabled
																},
																url : "http://localhost:8080/chisel/admin/util/config/tasktype/add/",
																success : function(
																		msg) {
																	console
																			.log(sent)
																}
															});
												}
												if ($(this).data("value2") === 'delete') {
													$
															.ajax({
																type : "post",
																crossDomain : true,
																headers : {
																	'tasktype' : $(this).data("value1")
																},
																url : "http://localhost:8080/chisel/admin/util/config/tasktype/delete/",
																success : function(
																		msg) {
																	console
																			.log(sent)
																}
															});
												}
											}

										});
					});
</script>
</head>
<body>

	<div>
		<h3>upload jars</h3>
		<form
			action="http://localhost:8080/chisel/admin/util/config/jar/loadjar/upload"
			method="post" enctype="multipart/form-data">
			<input type="file" name="file" multiple> <input type="submit" />
		</form>
	</div>


	<div>
		<h3>Task Types</h3>
		<table style="width: 50%" border="2">
			<tr>
				<th>Id</th>
				<th>TaskType</th>
				<th>ClassName</th>
				<th>Comment</th>
				<th>Enabled</th>
				<th>Run</th>
			</tr>
			<%
				for (Map<String, Object> x : Utils.getJsonList("/admin/util/config/tasktype/get/alltasktypes")) {
			%>

			<tr>
				<form method="post">
					<td><%=x.get("id")%></td>
					<td><%=x.get("taskType")%></td>
					<td><%=x.get("className")%></td>
					<td><%=x.get("comment")%></td>
					<td><%=x.get("isEnabled")%></td>
					<%
						if (((Boolean) x.get("isEnabled")).booleanValue()) {
					%>
					<td><button type="submit" data-value1="disable"
							data-value2="<%=x.get("taskType")%>" data-value3="TaskType">Disable</button></td>

					<%
						} else {
					%>
					<td><button type="submit" data-value1="enable"
							data-value2="<%=x.get("taskType")%>" data-value3="TaskType">Enable</button></td>
						<td><button type="submit" data-value1="<%=x.get("taskType")%>"
							data-value2="delete" data-value3="addTaskType">Delete</button>	
							</td>
				</form>
			</tr>
			<%
				}
			}
			%>

			<!-- <form action="/chiselgui/" method="get" > -->
			<tr>
				<td>AutoGen</td>
				<td><input type="text" name="taskType" id="newTaskType" /></td>
				<td><input type="text" name="className" id="newClassName" /></td>
				<td><input type="text" name="comment" id="newComment" /></td>
				<td><select name="isEnabled" id="newIsEnabled">
						<option value="true">true</option>
						<option value="false">false</option>
						<!-- <option value="mercedes">Mercedes</option>
  						<option value="audi">Audi</option> -->
				</select></td>
				<td><button data-value1="" data-value2="add"
						data-value3="addTaskType">Add</button></td>
			</tr>
			<!-- </form> -->

		</table>
	</div>

	<div>
		<h3>Runtimes</h3>
		<table style="width: 50%" border="2">
			<tr>

				<th>id</th>
				<th>runtime</th>
				<th>Run</th>
			</tr>

			<%
				for (Map<String, Object> x : Utils.getJsonList("/admin/util/config/runtime/get/allruntimes")) {
			%>
			<tr>
				<form method="get" action='/chiselgui/'>
					<td><%=x.get("id")%></td>
					<td><%=x.get("runtime")%></td>
					<td><button type="submit" data-value1="<%=x.get("runtime")%>"
							data-value3="RunTime">Undeploy</button></td>
				</form>
			</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>