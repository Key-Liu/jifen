document.getElementsByTagName("iframe")[0].contentWindow.document.getElementById("group_option").options.length=0;
		 		for(i=0;i<data.group_num;i++){
		 			document.getElementsByTagName("iframe")[0].contentWindow.document.getElementById("group_option").options.add(new Option(i+1,""+(i+1)+""));

#  pos 当前位置
			# pos = rise_num
			# for i in range(0,score_num):
			# # 剔除请假和缺席者 得出根据成绩排名的名单
			# 	if (score_object[i].result!="-2" and score_object[i].result!="0"):
			# 		# m = int(score_object[i].result[:2])
			# 		# s = int(score_object[i].result[2:4])
			# 		# ms = int(score_object[i].result[4:6])
			# 	# rank_dict[score_object[i].result] = m*60*1000 + s*1000 + ms
			# 		rank_list.append(score_object[i].result)

			# rank_list = sorted(rank_list, key=lambda d:d[1], reverse = True)
			# if sport_object.format == "1": 
			# 	rank_list.sort()
			# if sport_object.format == "0" :
			# 	rank_list.sort(reverse=True)
			# list_num = len(rank_list)

		# 成绩有效的人数大于晋级人数，rise_pos要确定最低成绩排位 否则直接取成绩有效的人数
			# if list_num > rise_num :
			# 	while (pos<list_num and rank_list[pos]==rank_list[rise_num-1]):
			# 		pos = pos + 1
			# # 找到晋级成绩的最低排位 pos为晋级人数  pos-1为最低排位
			# 	rise_pos = pos-1
			# 	# return HttpResponse(rise_pos)
			# else :
			# 	rise_pos = list_num - 1
	
		# 得到晋级人数