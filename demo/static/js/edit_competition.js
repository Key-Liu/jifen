	// post_url默认为空
	// option_value作为全局的值，来作为修改后提交的对应凭证
		$(document).ready(function(){	
		  // $("#competitions option").click(function(){
		  	$("#competitions").delegate("option","click",function(){
		  	// alert("click");
		  	// 如果是按option的话就是修改和编辑
		  	// 这里需要更改全局post_url
		  	var option_value = this.value;
		  	var post_url = "{% url 'demo:view_sport' %}"
		  	$("#right_title").html("修改项目");
		  	// $("#name").attr("disabled","disabled");
		  $.ajax({
			    type: 'POST',
			    url: post_url ,
			    data: {
			    	name : option_value,
			    } ,
			    cache:false,
			    success: function(data){     
			       $("#name").attr("value",data.sport_name);
			       $("#sort").attr("value",data.sort);
			       $("#format").attr("value",data.format);
			       $("#college_rec").attr("value",data.college_rec);
			       $("#campus_rec").attr("value",data.campus_rec);
			       $("#score_add").attr("value",data.score_add);
			       $("#group_num").attr("value",data.group_num);
			       $("#preliminary").attr("value",data.preliminary);
			       $("#rise").attr("value",data.rise); 
			       $("#post_url").attr("value","{% url 'demo:change_sport' %}");
			       $("#name").attr("disabled","disabled");
			    } ,
			    error:function (XMLHttpRequest, textStatus, errorThrown) {
			  // 通常情况下textStatus和errorThown只有其中一个有值 
			  alert(errorThrown); // the options for this ajax request
			},
		   dataType: "json"
			});

		  });
		// 上面是按option的反应
		// 这个add_competition是指点击那个"+"号之后的反应
		// 这里需要更改全局的post_url
			$("#add_competition,#reset").click(function(){
				// post_url = "{% url 'demo:add_sport' %}";
				// 因为修改和增加在同一个按钮实现，所以要用post_url来区别两个url
				// option_value = ""; 
				// 清空option值，防止无意中按了保存之类的，虽然post_url变了
				// 只是清空右方表格的值
				// $("#right_title").html("新增项目");
				$("#name").removeAttr("disabled"); 
				$("#name").attr("value","");
			    $("#sort").attr("value","");
			    $("#format").attr("value","");
			    $("#college_rec").attr("value","");
			    $("#campus_rec").attr("value","");
			    $("#score_add").attr("value","");
			    $("#group_num").attr("value","");
			    $("#preliminary").attr("value","");
			    $("#rise").attr("value","");


			});
			$("#adding").click(function(){
					name = $("#name").attr("value");
				    sort = $("#sort").attr("value");
				    format = $("#format").attr("value");
				    college_rec = $("#college_rec").attr("value");
				    campus_rec = $("#campus_rec").attr("value");
				    score_add = $("#score_add").attr("value");
				    group_num = $("#group_num").attr("value");
				    preliminary = $("#preliminary").attr("value");
				    rise = $("#rise").attr("value");
				    $("#name").removeAttr("disabled"); 
				if (!name||!sort||!format||!college_rec||!campus_rec||!score_add||!group_num||!preliminary||!rise)
				{
					alert("尚有信息未填写，请补充完毕再点击");
					return false;
				}

					// 如果是增加的话,ajax到增加
					$.ajax({
					    type: 'POST',
					    url: "{% url 'demo:add_sport' %}" ,
					    data: {
					    	name : name,
					    	sort : sort,
					    	format : format,
					    	college_rec:college_rec,
					    	campus_rec:campus_rec,
					    	score_add:score_add,
					    	group_num:group_num,
					    	preliminary:preliminary,
					    	rise:rise,
					    } ,
					    cache:false,
					    success: function(data){    
					       // 要立即在option里面显示这个option
					       if (data == "添加成功")
					       {
					       		$("#competitions").append("<option value=\"" + name + "\">" + name + "</option>");
					       }
					       // 清空右边
					       $("#name").attr("value","");
						    $("#sort").attr("value","");
						    $("#format").attr("value","");
						    $("#college_rec").attr("value","");
						    $("#campus_rec").attr("value","");
						    $("#score_add").attr("value","");
						    $("#group_num").attr("value","");
						    $("#preliminary").attr("value","");
						    $("#rise").attr("value","");
						    alert(data); 

					    } ,
					    error:function (XMLHttpRequest, textStatus, errorThrown) {
					  // 通常情况下textStatus和errorThown只有其中一个有值 
					  alert(errorThrown); // the options for this ajax request
					},
				   // dataType: "json"
				   // 把dataType注释掉系统反而会自动识别
					});
			});


			// 点了修改button之后的反应				
			$("#changing").click(function(){
				name = $("#name").attr("value");
				sort = $("#sort").attr("value");
				format = $("#format").attr("value");
				college_rec = $("#college_rec").attr("value");
				campus_rec = $("#campus_rec").attr("value");
				score_add = $("#score_add").attr("value");
				group_num = $("#group_num").attr("value");
				preliminary = $("#preliminary").attr("value");
				rise = $("#rise").attr("value");

				if (!name||!sort||!format||!college_rec||!campus_rec||!score_add||!group_num||!preliminary||!rise)
				{
					alert("尚有信息未填写，请补充完毕再点击");
					return false;
				}

				$.ajax({
					    type: 'POST',
					    url: "{% url 'demo:change_sport' %}" ,
					    data: {
					    	name : name,
					    	sort : sort,
					    	format : format,
					    	college_rec:college_rec,
					    	campus_rec:campus_rec,
					    	score_add:score_add,
					    	group_num:group_num,
					    	preliminary:preliminary,
					    	rise:rise,
					    } ,
					    cache:false,
					    success: function(data){    
					       // 要立即在option里面显示这个option
					       // 清空右边
					       	$("#name").attr("value","");
						    $("#sort").attr("value","");
						    $("#format").attr("value","");
						    $("#college_rec").attr("value","");
						    $("#campus_rec").attr("value","");
						    $("#score_add").attr("value","");
						    $("#group_num").attr("value","");
						    $("#preliminary").attr("value","");
						    $("#rise").attr("value","");
						    $("#name").removeAttr("disabled"); 
						    alert(data);

					    } ,
					    error:function (XMLHttpRequest, textStatus, errorThrown) {
					  // 通常情况下textStatus和errorThown只有其中一个有值 
					  alert(errorThrown); // the options for this ajax request
					},
				   // dataType: "json"
				   // 把dataType注释掉系统反而会自动识别
					});




			})


			// 下面是点了删除该运动（点击了"-"之后）之后的反应
			$("#delete_competition").click(function(){
				// 首先选中才能按删除，所以按删除之前有点已经ajax显示了一次
				// 并且option_value有值
				// var option_value = $("#option_value").attr("value");
				var option_value = $("#competitions option:selected").attr("value");
				var post_url = "{% url 'demo:del_sport' %}";
				if (option_value == "")
				{
					alert("请点选你要删除的运动项目,再按删除键!");
					return;
				}
				
				
				// var confirmation = confirm(确定删除该体育项目?);
				if (!confirm("确定删除该体育项目?"))
				{
					return false;
				}

				$.ajax({
			    type: 'POST',
			    url: post_url , // url for deleting sport
			    data: {
			    	name : option_value,
			    } ,
			    cache:false,
			    success: function(data){     
			       // 清空右方表格的值
					$("#name").attr("value","");
				    $("#sort").attr("value","");
				    $("#format").attr("value","");
				    $("#college_rec").attr("value","");
				    $("#campus_rec").attr("value","");
				    $("#score_add").attr("value","");
				    $("#group_num").attr("value","");
				    $("#preliminary").attr("value","");
				    $("#rise").attr("value",""); 
				   	$("#competitions option[value="+option_value+"]").remove(); 
				   	$("#name").removeAttr("disabled"); 
				   	//直接从DOM树中去除，下次刷新的时候就不见了
				    alert("成功删除!");

			    } ,
			    error:function (XMLHttpRequest, textStatus, errorThrown) {
			  // 通常情况下textStatus和errorThown只有其中一个有值 
			  alert(errorThrown); // the options for this ajax request
			},
		   // dataType: "json"
			});
				


			});

		});