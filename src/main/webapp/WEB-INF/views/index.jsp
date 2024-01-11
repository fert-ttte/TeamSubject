<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<title>안녕하세요</title>
<style>


</style>
</head>
<script src='<c:url value="/js/index.global.js"/>'></script>
<body>
<h2>${insert}</h2>
<div id='calendar'></div>
<div class="modal" id="modal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">알람</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        

      </div>
      <div class="modal-footer">
      	<button type="button" id="editbotton" class="btn btn-primary" data-bs-dismiss="modal">수정</button>
        <button type="button" id="deletbotton" class="btn btn-primary">삭제</button>
      </div>
    </div>
  </div>
</div>
</body>
<script>
document.addEventListener('DOMContentLoaded', function() {
	
    var calendarEl = document.getElementById('calendar');
    var id;
    const modal = document.getElementById("modal");
    const closeModalBtn = modal.querySelector(".btn-close");
    const editModalBtn = modal.querySelector("#editbotton");
    const deleteModalBtn = modal.querySelector("#deletbotton");
    const modalBody = modal.querySelector(".modal-body");
    var modalFooter = modal.querySelector(".modal-footer");
    fetch('/Callendar/CallenderList.do')
    .then(response => response.json())
    .then(data => {
        // 가공된 데이터를 사용하여 events 배열 생성
        var events = data.map(item => {
            return {
                id: item.no,
                title: item.title,
                start: item.start_,
                end: item.end_,
                alram: item.alram
            };
        });
        
        console.log(events)

        // 캘린더 초기화
        var calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                left: 'prevYear,prev,next,nextYear today',
                center: 'title',
                right: 'dayGridMonth,dayGridWeek,dayGridDay'
            },
            navLinks: true,
            editable: true,
            dayMaxEvents: true,
            events: events,  // 가공된 데이터를 사용하여 events 배열 설정
            eventClick: function(info) {
            	id=info.event.id;
            	modal.style.display = "block";
            	fetch("<c:url value="/Callendar/CallenderSelectOne.do?no="/>"+id)
    					.then(response=>response.json())
    					.then(data=>{
    						console.log(data)
    						const htmlContent =
                            "<p>할 일: " + data.title + "</p>" +
                            "<p>시작시간: " + data.start_ + "</p>" +
                            (data.end_ ? "<p>끝난시간: " + data.end_ + "</p>" : "") +
                            "<p>알람여부: " + data.alram + "</p>";
                            
                            modalBody.innerHTML = htmlContent;
    						
    					})
    					.catch(err=>console.log(err));
    					
    		     },
            
            
            dateClick: function(info){
            	modal.style.display = "block";
            	modalBody.innerHTML = "";
         	    modalFooter.innerHTML="<button type='button' id='editbotton2' class='btn btn-primary' data-bs-dismiss='modal'>입력</button>"
         	    const htmlContent =   
         	   "<p>입력 할 내용을 입력하세요.</p>"+
         	   "<textarea id='edit' style='width: 300px; height:300px;'></textarea>"
         	   modalBody.innerHTML = htmlContent;
         	  const editModalBtn2 = modal.querySelector("#editbotton2");
       	      const textarea = modal.querySelector("#edit");
       	   
       	  
       	   editModalBtn2.addEventListener("click", () => {
       		   const obj=JSON.parse(textarea.value);
       	    	 if (confirm("입력하시겠습니까??") == true){
       	    		 fetch("<c:url value="/Callendar/CallenderWrite.do?no="/>",{method: "POST", headers: {
       	    			    'Content-Type': 'application/json'
       	    		  },
       	    		  body: JSON.stringify(obj)}
       	    		 )
       	 			.then(response=>response.json())
       	 			.then(data=>{
       	 				alert(data.INSERT);
       	 				window.location.reload();
       	 			})
       	 			.catch(err=>console.log(err));
       	    		 

       	    	 }else{
       	    		window.location.reload();
       	    		return;

       	    	 }
       	    	
       	    	 
       	    	  modal.style.display = "none";
       	    		
       	    	  
                
       	        });
            }
            
           
            
        });
        



        // 캘린더 렌더링
        calendar.render();
        
    })
    .catch(error => console.error('Error:', error));
    
    
    closeModalBtn.addEventListener("click", () => {
  	  modal.style.display = "none";
  	  document.body.style.overflow = "auto"; // 스크롤바 보이기
  	  window.location.reload();
  	});
    
    
    deleteModalBtn.addEventListener("click", () => {
    	 if (confirm("정말 삭제하시겠습니까??") == true){
    		 fetch("<c:url value="/Callendar/CallenderDelete.do?no="/>"+id,{method: "DELETE"})
 			.then(response=>response.json())
 			.then(data=>{
 				alert(data.DeleteOk);
 				window.location.reload();
 			})
 			.catch(err=>console.log(err));

    	 }else{
    		return;

    	 }
    	 
    	  modal.style.display = "none";
    		
    	  
    });
    editModalBtn.addEventListener("click", () => {
	   modalBody.innerHTML = "";
	   modalFooter.innerHTML="<button type='button' id='editbotton2' class='btn btn-primary' data-bs-dismiss='modal'>수정</button>"
	   const htmlContent =   
	   "<p>수정할 내용을 입력하세요.</p>"+
	   "<textarea id='edit' style='width: 300px; height:300px;'></textarea>"
	   modalBody.innerHTML = htmlContent;
	   
	   const editModalBtn2 = modal.querySelector("#editbotton2");
	   const textarea = modal.querySelector("#edit");
	   
	  
	   editModalBtn2.addEventListener("click", () => {
		   const obj=JSON.parse(textarea.value);
	    	 if (confirm("수정하시겠습니까??") == true){
	    		 fetch("<c:url value="/Callendar/CallenderPut.do?no="/>"+id,{method: "PUT", headers: {
	    			    'Content-Type': 'application/json'
	    		  },
	    		  body: JSON.stringify(obj)}
	    		 )
	 			.then(response=>response.json())
	 			.then(data=>{
	 				alert(data.UpdateOk);
	 				window.location.reload();
	 			})
	 			.catch(err=>console.log(err));
	    		 

	    	 }else{
	    		window.location.reload();
	    		return;

	    	 }
	    	
	    	 
	    	  modal.style.display = "none";
	    		
	    	  
	    });
	   

    	    });

  });
</script>
</html>