<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>人事管理系统 ——公告管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="${pageContext.request.contextPath }/css/css.css"
	type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/ligerUI/skins/Aqua/css/ligerui-dialog.css" />
<link
	href="${pageContext.request.contextPath }/js/ligerUI/skins/ligerui-icons.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.11.0.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-migrate-1.2.1.js"></script>
<script
	src="${pageContext.request.contextPath }/js/ligerUI/js/core/base.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath }/js/ligerUI/js/plugins/ligerDrag.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath }/js/ligerUI/js/plugins/ligerDialog.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath }/js/ligerUI/js/plugins/ligerResizable.js"
	type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/css/pager.css"
	type="text/css" rel="stylesheet" />
<script type="text/javascript">
	$(function() {

		/** 获取上一次选中的部门数据 */
		var boxs = $("input[type='checkbox'][id^='box_']");

		/** 给全选按钮绑定点击事件  */
		$("#checkAll").click(function() {
			// this是checkAll  this.checked是true
			// 所有数据行的选中状态与全选的状态一致
			boxs.attr("checked", this.checked);
		})

		/** 给数据行绑定鼠标覆盖以及鼠标移开事件  */
		$("tr[id^='data_']").hover(function() {
			$(this).css("backgroundColor", "#eeccff");
		}, function() {
			$(this).css("backgroundColor", "#ffffff");
		})

		/** 删除公告绑定点击事件 */
		$("#delete").click(function() {
			/** 获取到公告选中的复选框  */
			var checkedBoxs = boxs.filter(":checked");
			if (checkedBoxs.length < 1) {
				$.ligerDialog.error("请选择一个需要删除的公告！");
			} else {
				/** 得到公告选中的所有的需要删除的ids */
				var ids = checkedBoxs.map(function() {
					return this.value;
				})

				$.ligerDialog.confirm("确认要删除吗?", "删除公告", function(r) {
					if (r) {
						// alert("删除："+ids.get());
						// 发送请求
						window.location.href = "DelNoticeSvl?ids=" + ids.get();
					}
				});
			}
		})

		/** 给预览绑定点击事件 */
		$("a[id^='prev_'").click(function() {
			var noticeid = this.id.replace('prev_', '');
			$.ligerDialog.open({
				title : '预览公告',
				height : 500,
				url : 'FindPreviewNoticeSvl?noticeid='+noticeid,
				width : 750,
				showMax : true,
				showToggle : true,
				showMin : true,
				isResize : true,
				slide : false
			});
		})
	})
	
	function gotoPage(totalPage){
		var num= $("#pager_jump_page_size").val()
		if(num>0 && num<=totalPage){
			window.location.href="FindAllNoticeSvl?current="+num;				
		}else{
			alert("跳转的页数只能是1-"+totalPage+"之间");
		}
	}
</script>
</head>
<body>
	<!-- 导航 -->
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="10"></td>
		</tr>
		<tr>
			<td width="15" height="32"><img
				src="${pageContext.request.contextPath }/images/main_locleft.gif"
				width="15" height="32"></td>
			<td class="main_locbg font2"><img
				src="${pageContext.request.contextPath }/images/pointer.gif">&nbsp;&nbsp;&nbsp;当前位置：公告管理
				&gt; 公告查询</td>
			<td width="15" height="32"><img
				src="${pageContext.request.contextPath }/images/main_locright.gif"
				width="15" height="32"></td>
		</tr>
	</table>

	<table width="100%" height="90%" border="0" cellpadding="5"
		cellspacing="0" class="main_tabbor">
		<!-- 查询区  -->
		<tr valign="top">
			<td height="30">
				<table width="100%" border="0" cellpadding="0" cellspacing="10"
					class="main_tab">
					<tr>
						<td class="fftd">
						<form action="SearchNoticeSvl" method="post">
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td class="font3">
									公告人：<input type="text" name="empname">
									公告名称：<input type="text" name="title">
									公告内容：<input type="text" name="content"> <input
										
										type="submit" value="搜索" /> 
										<c:if test="${sessionScope.role eq '2' }">
										<input id="delete" type="button" value="删除" />
										</c:if>
									</td>
								</tr>
							</table>
						</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<!-- 数据展示区 -->
		<tr valign="top">
			<td height="20">
				<table width="100%" border="1" cellpadding="5" cellspacing="0"
					style="border: #c2c6cc 1px solid; border-collapse: collapse;">
					<tbody>
						<tr class="main_trbg_tit" align="center">
						<c:if test="${sessionScope.role eq '2' }">
							<td><input type="checkbox" name="checkAll" id="checkAll"></td>
							</c:if>
							<td>公告人</td>
							<td>公告名称</td>
							<td>公告内容</td>
							<td>创建时间</td>
							<c:if test="${sessionScope.role eq '2' }">
							<td>操作</td>
							</c:if>
							<td>预览</td>
						</tr>
						<c:if test="${requestScope.flag eq '1' }">
						<c:forEach var="notice" items="${requestScope.pageinfo.lists}">
							<tr id="data_0" align="center" class="main_trbg"
								style="background-color: rgb(255, 255, 255);">
								<c:if test="${sessionScope.role eq '2' }">
									<td><input type="checkbox" id="box_0" value="${notice.noticeid}"></td>
								</c:if>
								<td>${notice.empname}</td>
								<td>${notice.noticename}</td>
								<td>${notice.noticecontent}</td>
								<td>${notice.createtime}</td>
								<c:if test="${sessionScope.role eq '2' }">
								<td align="center" width="40px;"><a
									href="notice/showUpdateNotice.jsp?noticeid=${notice.noticeid }&noticename=${notice.noticename}&noticecontent=${notice.noticecontent}&empid=${notice.empid}">
									 <img title="修改"
										src="${pageContext.request.contextPath }/images/update.gif"></a></td>
								</c:if>
								<td align="center" width="40px;"><a href="#" id="prev_${notice.noticeid }">
										<img title="预览"
										src="${pageContext.request.contextPath }/images/prev.gif">
								</a></td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${requestScope.flag ne '1' }">
						<c:forEach var="notice" items="${requestScope.notices}">
							<tr id="data_0" align="center" class="main_trbg"
								style="background-color: rgb(255, 255, 255);">
								<c:if test="${sessionScope.role eq '2' }">
								<td><input type="checkbox" id="box_0" value="${notice.noticeid}"></td>
								</c:if>
								<td>${notice.empname}</td>
								<td>${notice.noticename}</td>
								<td>${notice.noticecontent}</td>
								<td>${notice.createtime}</td>
								<c:if test="${sessionScope.role eq '2' }">
								<td align="center" width="40px;"><a
									href="notice/showUpdateNotice.jsp?noticeid=${notice.noticeid }&noticename=${notice.noticename}&noticecontent=${notice.noticecontent}&empid=${notice.empid}">
									 <img title="修改"
										src="${pageContext.request.contextPath }/images/update.gif"></a></td>
								</c:if>
								<td align="center" width="40px;">
								<a href="#" id="prev_${notice.noticeid }">
										<img title="预览"
										src="${pageContext.request.contextPath }/images/prev.gif">
								</a></td>
							</tr>
						</c:forEach>
						</c:if>
					</tbody>
				</table>
			</td>
		</tr>
		<!-- 分页标签 -->
		<c:if test="${requestScope.flag eq '1' }">
		<tr valign="top">
			<td align="center" class="font3">
				<table width="100%" align="center" style="font-size: 13px;"
					class="digg">
					<tbody>
						<tr>
							<td
								style="COLOR: #0061de; MARGIN-RIGHT: 3px; PADDING-TOP: 2px; TEXT-DECORATION: none">
								<span class="disabled"> 
								<c:if test="${pageinfo.currentPage ne 1}">
										<a href="FindAllNoticeSvl?current=${pageinfo.currentPage-1}">上一页</a>
								</c:if>
							</span> <!-- 	<span class="current">1</span> --> 
							<span class="disabled">
									<c:if test="${pageinfo.currentPage !=pageinfo.totalPage}">
										<a href="FindAllNoticeSvl?current=${pageinfo.currentPage+1}">下一页</a>
									</c:if>
							</span>&nbsp;跳转到第<input
								style="text-align: center; BORDER-RIGHT: #aaaadd 1px solid; PADDING-RIGHT: 5px; BORDER-TOP: #aaaadd 1px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 2px; MARGIN: 2px; BORDER-LEFT: #aaaadd 1px solid; COLOR: #000099; PADDING-TOP: 2px; BORDER-BOTTOM: #aaaadd 1px solid; TEXT-DECORATION: none"
								type="text" size="2" id="pager_jump_page_size">页&nbsp;<input
								type="button"
								style="text-align: center; BORDER-RIGHT: #dedfde 1px solid; PADDING-RIGHT: 6px; BACKGROUND-POSITION: 50% bottom; BORDER-TOP: #dedfde 1px solid; PADDING-LEFT: 6px; PADDING-BOTTOM: 2px; BORDER-LEFT: #dedfde 1px solid; COLOR: #0061de; MARGIN-RIGHT: 3px; PADDING-TOP: 2px; BORDER-BOTTOM: #dedfde 1px solid; TEXT-DECORATION: none"
								value="确定" id="pager_jump_btn"
								onClick="gotoPage(${pageinfo.totalPage})">
							</td>
						</tr>
						<tr align="center">
							<td style="font-size: 13px;"></td>
						</tr>
						<tr>
							<td
								style="COLOR: #0061de; MARGIN-RIGHT: 3px; PADDING-TOP: 2px; TEXT-DECORATION: none">总共<font
								color="red">${pageinfo.totalCount}</font>条记录，当前显示第${pageinfo.currentPage}页数据。
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		</c:if>
		<c:if test="${requestScope.flag ne '1' }">
			<tr valign="top">
			<td align="center" class="font3">
				<table width="100%" align="center" style="font-size: 13px;"
					class="digg">
					<tbody>
					<tr>
							<td
								style="COLOR: #0061de; MARGIN-RIGHT: 3px; PADDING-TOP: 2px; TEXT-DECORATION: none">总共<font
								color="red">${requestScope.count}</font>条记录.
							</td>
						</tr>
						</tbody>					
					</table>
				</td>
			</tr>
		</c:if>
	</table>
	<div style="height: 10px;"></div>
</body>
</html>