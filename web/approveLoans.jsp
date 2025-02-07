<%-- 
    Document   : dashboard
    Created on : Jun 20, 2022, 3:18:46 PM
    Author     : User
--%>

<%@page import="model.ApplicantVerification"%>
<%@page import="model.LoanDetails"%>
<%@page import="model.ApproveRequest"%>
<%@page import="model.DataSupply"%>
<%@page import="model.LoanDetailSupply"%>
<%@page import="model.Admindetails"%>
<%@page import="imageloader.Loader"%>
<%@page import="java.util.List"%>
<%@page import="model.LoanRequest"%>
<%@page import="model.AdminUser"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0">

    <title>Approve Loans</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.css">
  	  
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css">
   
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> 
 <link rel="stylesheet" href="fontawesome-free-6.1.1-web/css/all.css" />
 <link rel="icon" type="image/x-icon" href="kam.png">
  <style>
  
.sidebar {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  z-index: 100;
  padding: 90px 0 0;
  box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
  z-index: 99;
}

@media (max-width: 767.98px) {
  .sidebar {
    top: 11.5rem;
    padding: 0;
  }
}

.navbar {
  box-shadow: inset 0 -1px 0 rgba(0, 0, 0, .1);
}

@media (min-width: 767.98px) {
  .navbar {
    top: 0;
    position: sticky;
    z-index: 999;
  }
}

.sidebar .nav-link {
  color: #333;
}

.sidebar .nav-link.active {
  color: #0d6efd;
}

i{
  font-size: 1.3rem;
  text-align: left;
}

.nav-item a{
  transition: .5s ease;
  text-align: left;
}

.nav-item a:hover{
  color: #0d6efd;
}
  
.model-container{
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    pointer-events: none;
    opacity: 0;
    transition: visibility 0s, opacity 0.5s;
}

.model-container.show{
    opacity: 1;
    pointer-events: auto;
}
.model-container .model{
    background-color: #fff;
    padding: 30px 50px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2);  
}

.model{
    position: relative;
}

.model p{
    opacity: 0.7;
    font-size: 18px;
}

.form-container.blu{
    filter: blur(5px);
}

.model .close{
    position: absolute;
    top: 20px;
    right: 20px;
    font-weight: bolder;
    color: red;
    cursor: pointer;
}
  
  </style>

  
  <script type="text/javascript">
        function preventBack() { window.history.forward(); }
        
        setTimeout("preventBack()", 0.0);
        window.onunload = function () { null };
    </script>
 
 </head>
<body>

     <script type = "text/javascript" >
          history.pushState(null, null, 'approveLoans.jsp');
          window.addEventListener('popstate', function (event) {
              history.pushState(null, null, 'approveLoans.jsp');
      });

     </script>
     
    <%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache"); 
response.setHeader ("Expires", "0"); //prevents caching at the proxy server
%>


    <%!String name="", position="",email="", pic1="",pic2="", id="", transid="", phone="", verificationid="", date = "", loanamount="", total = "", interest="", firstname="", lastname="", applicantemail="", email2="";%>
   
    <%
     AdminUser s = (AdminUser)session.getAttribute("staff");
      name=s.getFirstname() + " " + s.getLastname();
      position=s.getPosition();
      email=s.getEmail();
      session.setAttribute("agentname", name);
      session.setAttribute("agentemail", email);
    
    if((position.equals("Inspector") || position.equals("Inspector")) &&  email!=null){
        
    }else{
    response.sendRedirect("index.jsp");
    }    
    
    
        pic1=(String)session.getAttribute("pic1");
        pic2=(String)session.getAttribute("pic2");
        if((pic1!=" " && pic2!="")&&(pic1!=null && pic2!=null) ){
        Loader.loadIddelete(pic1, pic2);
        }
        
         LoanDetailSupply loandetail = data.Database.verifyCol(request.getParameter("trid"));
         
         data.Database.getApproveRequest(request.getSession());
         
         List<LoanRequest> trans = data.Database.getviewRequest("Submitted");
         ArrayList<String> collectTransID = new ArrayList<String>();
         for(LoanRequest lr: trans){
           transid = lr.getTrid();
           collectTransID.add(transid);
           applicantemail=lr.getEmail();
         }
         
         List<ApplicantVerification> apv = data.Database.getVerifiedApplicant(applicantemail);
         for(ApplicantVerification av:apv){
             email2= av.getApplicantEmail();
         }
    %> 

<nav class="navbar navbar-light bg-light p-3">
  <div class="d-flex col-12 col-md-3 col-lg-2 mb-2 mb-lg-0 flex-wrap flex-md-nowrap justify-content-between">
      <a class="navbar-brand" href="#">
          <img src="images/kam.png" width="40px" class="rounded-pill">&nbsp; <%=position %>
		  
      </a>
      <button class="navbar-toggler d-md-none collapsed mb-3" type="button" data-toggle="collapse" data-target="#sidebar" aria-controls="sidebar" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
      </button>
  </div>
  <div class="col-12 col-md-4 col-lg-2">
  <form action="kambok.jsp">
      <div class="input-group">
  <input type="text" class="form-control" placeholder="Search">
  <button class="btn btn-dark" type="submit" >Search</button>
  </form>
</div>
  </div>
  <div class="col-12 col-md-5 col-lg-8 d-flex align-items-center justify-content-md-end mt-3 mt-md-0">
      <div class="mr-3 mt-1">

      </div>
      <div class="dropdown">
          <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-expanded="false">
               Hello, <%=name %>
          </button>
          <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <li><a class="dropdown-item" href="#">Settings</a></li>
            <li><a class="dropdown-item" href="#">Messages</a></li>
            <li><a class="dropdown-item" href="logout">Sign out</a></li>
          </ul>
        </div>
  </div>
</nav>
    
<div class="container-fluid">
<nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
  <div class="row">
        
<div class="position-sticky pt-md-5">
  <ul class="nav flex-column">
         <li class="nav-item ml-4">
        <a class="nav-link active" href="inspectionDashboard.jsp">
          <i class="fa-solid fa-calendar-check mx-2"></i>
          <span class="ml-2" >Inspect</span>
        </a>
         </li>
         <li class="nav-item ml-4">
        <a class="nav-link" href="inspectionDashboard.jsp">
          <i class="fa-solid fa-gift mx-2"></i>
          <span class="ml-2" >Redeem</span>
        </a>
         </li>
    </ul>
</div>
  
</nav>
<main class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
        
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="#">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Overview</li>
  </ol>
</nav>

    
<div class="card form-container" id="formDiv">
  <h5 class="card-header">Approved Loans</h5>
  <div class="card-body">
    <table class="table table-primary  table-bordered text-center">
                      <thead>
                        <tr>
                          <th >Transaction ID</th>
                          <th >Loan Amount</th>
                          <th >Interest</th>
                          <th >Duration</th>
                          <th >Loan Date</th>
                          <th >Due Date</th>
                          <th >Status</th>
                          <th ></th>
                         </tr>
                         <%
                           List<LoanDetails> lr=data.Database.getApproveRequest(request.getSession());
                           for(LoanDetails l:lr){
                          out.println("<tr class='table-light'><td>"+l.getTrid()+"</td><td>₦"+l.getLoanamount()+"</td><td>₦"+l.getInterest()+"</td><td>"+l.getDuration()+"</td><td>"+l.getLoandate()+"</td><td>"+l.getRepaydate()+"</td><td>"+l.getStatus()+"</td><td><form name='myform' action='approveLoans.jsp' method='get' id='myform'><input type='hidden' name='trid' id='tri' value='"+l.getTrid()+"'> <button class='btn btn-primary' id='submitBtn' type='submit'>View</button></form></td></tr>");     
                           }
                         
                         %>  
                  </table>
  </div>
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
                  <br />
<div class="row">
  <div class="col-12 col-xl-12 mb-4 mb-lg-0">
    
<footer class="pt-5 d-flex justify-content-between">
  <span>Copyright &copy; 2022-2024 <a href="https://kambokinfotech.com">Kambok Infotech Limited</a></span>
  <ul class="nav m-0">
      <li class="nav-item">
        <a class="nav-link text-secondary" aria-current="page" href="#">Privacy Policy</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-secondary" href="#">Terms and conditions</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-secondary" href="#">Contact</a>
      </li>
    </ul>
</footer>
  
</div>

</div>
  </div>

  <div class="row" >
        <div class="col-md-12">
            <div class="model-container d-flex justify-content-center align-items-center" id="modelContainer">
               <div class="row d-flex justify-content-center">
                <div class="col-md-5 col-xs-6 col-sm-6 model text-center  ">
                    <form action="verify" method="post" class="form" enctype="multipart/form-data" id="form1">
                        <h1>Applicant Additional Information <i class="fa-solid fa-inbox-out text-secondary"></i></h1>
                        <p>Collect Applicant's Phone number and means of Identification</p>
                        <br><br>
                      <div class="form-outline mb-4">
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text p-3">
                                            <span class="fa fa-phone"></span>
                                        </span>                    
                                    </div>
                                    <input type="text" class="form-control" placeholder="Phone number" required="required" name="phone">
                                </div>
                            </div> 
                        </div>  
                        <div class='form-group'>
                             <label for="id" class="form-label">Applicant ID</label>
                              <input type="file" class="form-control" id="id" name="applicantid">
                        </div>
                    <input type="hidden" class="form-control" required="required" name="trid" id="trid2" value="<%= request.getParameter("trid1") %>">
                    <input type="hidden"  class="form-control p-3"  name="agentName" value="<%= name %>" >
                     <input type="hidden"  class="form-control p-3"  name="agentEmail" value="<%= email %>">
                     <input type="hidden"  class="form-control p-3"  name="applicantEmail" value="<%= applicantemail %>" >
                     <input type="hidden"  class="form-control p-3"  value="<%= applicantemail%>" id="applicantemail">
                     <input type="hidden" value="<%= email2 %>" id="appemail2">
                     <br><br>
                     <button type="submit"  class="btn btn-success">Continue</button>
                    </form>
                     <form action="verify2" method="post" class="form" id="form2">
                        <h1>Applicant Additional Information <i class="fa-solid fa-inbox-out text-secondary"></i></h1>
                        <br><br>
                    <p>This applicant has been verified</p>
                    <div class="img-responsive text-center">
                            <img src="verify.jpg" width="90">
                        </div>
  
                    <input type="hidden" class="form-control" required="required" id="trid3"  name="tranid" value="<%= request.getParameter("trid1") %>">                   
                     <br><br>
                     <button type="submit"  class="btn btn-success">Proceed</button>
                     
                    </form> 
                     <span id="close-btn" class="close">X</span>
                   </div>
            </div>
            </div>
        </div> 
    </div>
    <script>
        const open = document.getElementById("submitBtn");
        const modelContainer = document.getElementById("modelContainer");
        const close = document.getElementById("close-btn");
        const blurContainer = document.getElementById("formDiv");
        const myform = document.getElementById("myform");
        var form1 = document.getElementById("form1");
        var form2 = document.getElementById("form2");
        var applicantEmail = document.getElementById("applicantemail").value;
        var applicantEmail12 = document.getElementById("appemail2").value; 
            function confirmTransID(){
                     if(applicantEmail==applicantEmail12){
                        modelContainer.classList.add('show');
                        blurContainer.classList.add('blu');
                        form1.style.display = "none";
                     }else{
                        modelContainer.classList.add('show');
                        blurContainer.classList.add('blu');
                        form2.style.display = "none";
                     }
         }
     
       myform.addEventListener('submit', ()=>{
            event.preventDefault();
            
            var tri = document.getElementById("tri").value;
            var trid2= document.getElementById("trid2");
            var trid3= document.getElementById("trid3");
            trid2.value = tri
            trid3.value = tri
        });
        
        function confirmPass(){
            let pass = document.getElementById("pass").value;
            let pass2 = document.getElementById("pass2").value;
            let report = document.getElementById("report");

            if(pass!=pass2){
                report.style.color = "red";
                report.innerHTML = "No account associated with this email";
                document.getElementById("submitBtn").disabled = true;
            }else{
                report.style.color = "green";
                report.innerHTML = "";
                document.getElementById("submitBtn").disabled = false;
            }
        }
        
        open.addEventListener('click', ()=>{
            confirmTransID(); 
        });
        close.addEventListener('click', ()=>{
            modelContainer.classList.remove('show');
            blurContainer.classList.remove('blu');
        });
        
      
    </script>




  
</body>
</html>
  
