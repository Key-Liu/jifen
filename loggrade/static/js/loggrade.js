$(document).ready(function(){
	// $("#athlete_id").delegate("text","onblur",function(){
	// 	var post_url = "{% url 'loggrade:athlete_id_ajax' %}"
	// 	var text_value = this.value
	// 	$.ajax({
	// 		type:'POST',
	// 		url:post_url,
	// 		data:{
	// 			athlete_id:text_value,
	// 		},
	// 		cache:false,
	// 		success:function(data){
	// 			$("#name").attr("value",data.name);
	// 			$("#class_id").attr("value",data.class_id);
	// 		},
	// 		error:function(XMLHttpRequest, textStatus, errorThrown){
	// 			alert(errorThrown);
	// 		},
	// 		dataType: "json"
	// 		});
	// });

	// $("#group_choice").delegate("option","click",function(){
	// 	var group = this.value
	// 	var group_num = $("#group_num").attr("value") 
	// 	$("#group").attr("value",group);
	// 	// # 最后一组显示计算排名按钮
	// 	if (group==group_num)       
	// 		{                     
	// 			$("#operation").append("<button>计算排名</button>");
	// 		}
	// });
    $("#sport_name").attr("value","dada");
	$("#view_sport").delegate("option","click",function(){
		var option_value = this.value
		var post_url = "{% url 'loggrade:view_sport' %}"
		$.ajax({
			type:'POST',
			url:post_url,
			data:{ 
				sport_name:option_value,
			},
			cache:false,
			success:function(data){
				$("#sport_name").attr("value",data.sport_name);
				$("#group_num").attr("value",data.group_num);
				$("#player_num").attr("value",data.player_num);
				$("#campus_rec").attr("value",data.campus_rec);
				$("#college_rec").attr("value",data.college_rec);
				// 若初赛标记为0，则单选按钮失效
				if(data.preliminary == 0){
					$("#preliminary").attr("disabled",true);
				}
				//录入人数
				
				//计分格式
				format = data.format
				if(format == "1"){
                 //css html 操作 
				} else if(format == 0){
                 //css html 操作 
				} else alert("成绩格式标志位录入出错！");
				//录入人数 $("#playered_num").attr("value",data.playered_num);  
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				alert(errorThrown);
			},
			dataType: "json",
		});
	});

// 初赛/决赛单选框点击函数
	// $("#preliminary").delegate("radio","click",function(){
	// 	$(this).attr("value","1");
	// 	$("#_final").attr("value","");
	// });
	// $("#_final").delegate("radio","click",function(){
	// 	$(this).attr("value","1");
	// 	$("#preliminary").attr("value","");
	// });

	// $("#login_score").delegate("button","click",function(){
	// 	 // 录入成绩按钮，清空各个域除group外
	// 	    var sport_name = $("#sport_name").attr("value")
	// 	    var group = $("#group").attr("value")
	// 	    var athlete_id = $("#athlete_id").attr("value")
	// 	    var class_id = $("#class_id").attr("value")
	// 	    var result = $("#result").attr("value")
	// 	    var _final
	// 	 if($("#preliminary").value == "1")  _final = "0"
	// 	     else if($("#_final").value == "1")  _final = "1";

	// 	    var post_url = "{% url 'loggrade:login_score' %}"
	// 	 if(!_final||!sport_name||!group||!athlete_id||!class_id||!result){
	// 	 	alert("尚有信息未填写，请补充完毕再点击");
	// 	    return false;
	// 	 }
	// 	 $.ajax({
	// 	 	url:post_url,
	// 	 	type:'POST',
	// 	 	data:{
	// 	 		sport_name : sport_name,
	// 	 		group : group,
	// 	 		athlete_id : athlete_id,
	// 	 		class_id : class_id,
	// 	 		result : result, 
	// 	 		_final : _final,
	// 	 	},
	// 	 	cache:false,
	// 	 	success:function(data){
	// 	 		$("#group").attr("value","")
	// 	 		$("#name").attr("value","")
	// 	 		$("#athlete_id").attr("value","")
	// 	 		$("#class_id").attr("value","")
	// 	 		$("#result").attr("value","")
	// 	 		$("#preliminary").attr("value","")
	// 	 		$("#_final").attr("value",""),
	// 	 		alert(data);
	// 	 	},
	// 	 	error:function(XMLHttpRequest, textStatus, errorThrown){
	// 			alert(errorThrown);
	// 		},
	// 	 	dataType : 'json',    
	// 	 	// 注释掉自动识别？
	// 	 });
	// });

	// $("#search_score").delegate("button","click",function(){
	// 	var sport_name = $("#sport_name").value ;
	// 	var athlete_id = $("#athlete_id").value ;
	// 	var class_id = $("#class_id").value ;
	// 	var post_url = "{% url 'loggrade/search_score_ajax' %}"
	// 	$.ajax({
	// 		url:post_url,
	// 		type:'POST',
	// 		data:{
	// 			sport_name : sport_name,
	// 			athlete_id : athlete_id,
	// 			class_id : class_id,
	// 		},
	// 		cache:false,
	// 		success:function(data){
	// 		    $("#result").attr({"value",data.result,"disabled",true}); 
	// 		    $("#group").attr("value",data.group);
	// 		    // 设置初赛/决赛 单选框
 //                if(data._final == "1"){
 //                	$("_final").attr("value","1");
 //                } else {
 //                	$("preliminary").attr("value","1");
 //                }
	// 		},
	// 		error:function(XMLHttpRequest, textStatus, errorThrown){
	// 			alert(errorThrown);
	// 		},
	// 		dataType:'json'
	// 	});
	// 	//添加一个修改按钮
	// });
	// // var change_score_times = 0;
	// $("#change_score").delegate("button","click",function(){
	// 	// 模拟静态函数？
	// 	change_score_times = change_score_times || 0 ;
	// 	change_score_times ++;
	// 	var post_url = "{% url 'loggrade:change_score' %}"
	// 	var result = $("#result").value
	// 	var group = $("#group").attr("value")
	// 	var sport_name = $("#sport_name").attr("value")
	// 	var athlete_id = $("#athlete_id").attr("value")
	// 	var class_id = $("#class_id").attr("value")
			
	// 	if(change_score_times % 2 ==1) {
	// 		$("#result").attr("disabled",false);
	// 		$("#change_score").html("确定");
	// 	} else {
	// 		$("#change_score").attr("type","hidden");
	// 		$.ajax({
	// 			url:post_url,
	// 			type:'POST',
	// 			data:{
	// 				sport_name:sport_name,
	// 				athlete_id:athlete_id,
	// 				class_id:class_id,
	// 				group:group,
	// 				result:result,
	// 				_final:_final,
	// 			},
	// 			cache:false,
	// 			success:function(data){
	// 				$("#group").attr("value","")
	// 	 		    $("#name").attr("value","")
	// 	 		    $("#athlete_id").attr("value","")
	// 	 		    $("#class_id").attr("value","")
	// 	 		    $("#result").attr("value","")
	// 	 		    $("#preliminary").attr("value","")
	// 	 		    $("#_final").attr("value",""),
	// 	 		    alert(data);
	// 			},
	// 			error:function(XMLHttpRequest, textStatus, errorThrown){
	// 			alert(errorThrown);
	// 		    },
	// 			dataType:'json'
	// 		});
	// 	}
		
	// });
});