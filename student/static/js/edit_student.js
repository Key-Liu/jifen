$(document).ready(function(){
	$.ajax({
			    type: 'POST',
			    url: "{% url 'student:view_student' %}" ,
			    cache:false,
			    success:function(data){
					alert("good");
					},

//			     success: function(data){     
//			         for (student in data)
//					 {
//						 alert("good");
//						 $("#students").append("<tr>
//             				<td >{{student.major}}</td>
//             				<td class="center num">{{student.num}}</td>
//            					<td class="center name">{{student.name}}</td>
//             				<td class="center athlete_id">{{student.athlete_id}}</td>
//             				<td class="center">
//                 				<button class="btn btn-info" href="#">
//                     				<i class="glyphicon glyphicon-edit icon-white edit_btn"></i>
//                     					Edit
//                					</button>
//                 				<button class="btn btn-danger" href="#">
//                     				<i class="glyphicon glyphicon-trash icon-white delete_btn"></i>
//                     					Delete
//                 				</button>
//             				</td>
//         				</tr>");
//					 }
//			     } ,
			    error:function (XMLHttpRequest, textStatus, errorThrown) {
			  	alert(errorThrown); 
				},
		    	//dataType: "json"
	});
});
	