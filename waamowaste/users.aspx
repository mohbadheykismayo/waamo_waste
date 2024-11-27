<%@ Page Title="" Language="C#" MasterPageFile="~/home.Master" AutoEventWireup="true" CodeBehind="users.aspx.cs" Inherits="waamowaste.users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
        #map-container {
    width: 100%; /* Ensures it takes the full width of the parent container */
    height: 100%; /* Ensures it takes the full height of the parent container */
}


#map {
    width: 100%; /* The map will stretch to the full width of the container */
    height: 400px; /* Set a fixed height for the map in normal view */
}


@media (max-width: 768px) {
    #map {
        height: 300px; /* Reduce map height for smaller screens */
    }
}


@media (max-width: 576px) {
    #map {
        height: 250px; /* Further reduce map height for mobile view */
    }
}


    /* Make the modal landscape oriented (wider) */
    .modal-lg {
      max-width: 90vw; /* Wider modal */
      height: auto;
    }


    .modal-content {
      border-radius: 10px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
      background-color: #fff;
    }



    .modal-header {
      background: linear-gradient(45deg, #007bff, #6610f2);
      color: white;
      padding: 1.5rem;
      border-bottom: none;
    }
    
    .modal-title {
      font-size: 1.7rem;
      font-weight: 700;
    }


    .modal-body {
      background-color: #f5f5f5;
      padding: 2rem;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
    }

    .modal-footer {
      border-top: none;
      padding: 1.5rem;
      justify-content: center;
    }

    .form-control {
      border-radius: 30px;
    }

    .form-label {
      font-weight: 600;
    }

    .form-group {
      margin-bottom: 1.5rem;
      flex: 1 1 45%;
    }

    .btn-primary {
      background: linear-gradient(45deg, #007bff, #6610f2);
      border: none;
      border-radius: 30px;
      padding: 0.75rem 2rem;
      font-size: 1rem;
      font-weight: 600;
    }

    .btn-secondary {
      border-radius: 30px;
      font-size: 1rem;
    }

    .input-group-text {
      border-radius: 30px 0 0 30px;
      background: #007bff;
      color: white;
      border: none;
    }

    /* Ensure the input groups have full width */
    .input-group {
      width: 100%;
    }


     .bg-gradient-primary {
        background: linear-gradient(45deg, #007bff, #6610f2);
    }

    .table thead {
        background-color: #007bff;
    }

    .table th {
        color: white;
    }

    .btn-outline-primary,
    .btn-outline-success,
    .btn-outline-warning {
        border-radius: 30px;
    }

    .btn-added img {
        height: 20px;
    }

    .card {
        border-radius: 10px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }

    .modal-footer {
        display: flex;
        justify-content: center;
        padding-top: 1.5rem;
    }

    .modal-footer .btn {
        padding: 0.75rem 2rem;
        border-radius: 30px;
    }
    </style>
<style>
  /* Modal Styles for #tabModal */
  #tabModal .modal-lg {
      max-width: 95vw;
      height: auto;
  }
  .is-invalid {
    border-color: red;
}


  #tabModal .modal-content {
      border-radius: 15px;
      box-shadow: 0 15px 50px rgba(0, 0, 0, 0.3);
      background-color: #f9f9f9;
      height: 90vh; /* Make modal occupy 90% of the viewport height */
  }

  #tabModal .modal-header {
      background: linear-gradient(45deg, #007bff, #6610f2);
      color: white;
      padding: 1.5rem;
      border-bottom: none;
      border-top-left-radius: 15px;
      border-top-right-radius: 15px;
  }

  #tabModal .modal-title {
      font-size: 2rem;
      font-weight: 700;
  }

  #tabModal .modal-body {
      padding: 0;
      height: 100%;
      display: flex;
      flex-direction: column;
  }

  /* Tabs Styling */
  #tabModal .nav-tabs {
      margin: 1rem;
  }

  #tabModal .nav-tabs .nav-link {
      color: #007bff;
      font-weight: 600;
      border-radius: 30px;
      padding: 0.75rem 1.5rem;
  }

  #tabModal .nav-tabs .nav-link.active {
      background-color: #007bff;
      color: white;
      border-radius: 30px;
      box-shadow: 0 5px 15px rgba(0, 123, 255, 0.5);
  }

  /* Responsive Content Container */
  #tabModal .tab-content {
      flex-grow: 1;
      overflow: hidden;
  }

  /* Table Styles */
  #tabModal .table-responsive {
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
  }

  #tabModal .table {
      width: 100%;
      height: 100%;
      margin: 0;
      overflow-y: auto;
  }

  #tabModal .table th, #tabModal .table td {
      padding: 1rem;
      text-align: center;
  }


  #tabModal .table thead {
      background-color: #007bff;
      color: white;
      font-weight: 700;
  }


  /* Map Container */
  #map-container {
      width: 100%;
      height: 100%;
      overflow: hidden;
  }
  /* Map Container */
#map-container1 {
    width: 100%;
    height: 100%;
    overflow: hidden;
}

#map-container2 {
    width: 100%;
    height: 100%;
    overflow: hidden;
}

  #map {
      width: 100%;
      height: 100%;
  }


  /* Map iframe responsive */
  .map-responsive iframe {
      width: 100%;
      height: 100%;
      border: 0;
  }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Modal -->
    <div class="modal fade" id="xafadamodal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel11">Ku Dar waax , Kana Badal</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <div class="page-header">
                        <div class="page-title">
                            <h4>Items Add to Stock</h4>

                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <input id="id1" style="display: none" />
                                <div class="col-lg-4 col-sm-6 col-12" id="dropee">
                                    <div class="form-group">
                                        <label>Xaafada</label>
                                        <select class="select" id="itemdrop">
                                        </select>
                                        <small id="xafad1" class="text-danger"></small>
                                    </div>
                                </div>

                                <div class="col-lg-4 col-sm-6 col-12" id="dropee1">
                                    <div class="form-group">
                                        <label>Xaafada</label>
                                        <select class="select" id="itemdwaxdarop">
                                        </select>
                                        <small id="xafad13" class="text-danger"></small>
                                    </div>
                                </div>






                                <div class="col-lg-12">
                                    <a href="javascript:void(0);" id="deletebtn1" class="btn btn-submit me-2" onclick="deletecategory()">delete</a>
                                    <a href="javascript:void(0);" id="editbtn1" class="btn btn-submit me-2" onclick="updateitemstock()">edit</a>
                                    <a href="javascript:void(0);" id="editbtn11" class="btn btn-submit me-2" onclick="badalwaax()">edit</a>

                                    <a href="javascript:void(0);" id="submitbtn1" class="btn btn-submit me-2" onclick="kudarxafad()">Submit</a>
                                    <a href="categorylist.html" class="btn btn-cancel" data-bs-dismiss="modal">Cancel</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <%-- <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Understood</button>
      </div>--%>
            </div>
        </div>
    </div>


    <!-- Modal -->
    <div class="modal fade" id="stockmodal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="staticBackdropLabel1">Ku Dar Waax, Kana Badal</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                                 <input id="id6" style="display:none" />
                           <input id="id7" style="display:none" />

                    <div class="card w-100  shadow-sm">
                        <div class="card-body">

                            <div class="row">
                                <div class="col-12">
                                    <div class="table-responsive">
                                        <table class="table  " id="shaqale">
                                            <thead>
                                                <tr>

                                                    <th>fullname</th>
                                                    <th>UserRole</th>
                                                    <th>Position</th>
                                                    <th>Salary</th>
                                                    <th>Username</th>
                                                    <th>PasswordHash</th>
                                                  <th>number</th>
                                                          <th>date</th>
                                                             <th>status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <br />
                            <!-- Tabs Section -->
                            <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="tab1-tab" data-bs-toggle="tab" data-bs-target="#tab1-content" type="button" role="tab" aria-controls="tab1-content" aria-selected="true">Xaafada</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="tab2-tab" data-bs-toggle="tab" data-bs-target="#tab2-content" type="button" role="tab" aria-controls="tab2-content" aria-selected="false">User Edit</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="tab3-tab" data-bs-toggle="tab" data-bs-target="#tab3-content" type="button" role="tab" aria-controls="tab3-content" aria-selected="false">Changer Username And Password</button>
                                </li>
                            </ul>

                            <!-- Tab Content -->
                            <div class="tab-content mt-4" id="myTabContent">

                                <!-- Tab 1 -->
                                <div class="tab-pane fade show active" id="tab1-content" role="tabpanel" aria-labelledby="tab1-tab">
                                    <button class="btn btn-outline-primary w-100 mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTab1" aria-expanded="false" aria-controls="collapseTab1">
                                        Show/Hide Xaafadaha iyo Waaxyaha
                                    </button>
                                    <div class="collapse" id="collapseTab1">
                                        <div class="card card-body border-primary">

                                            <div class="page-btn">
                                                <a href="#" class="btn  btn-outline-primary btn-added" onclick="callmodal()">
                                                    <img src="assets/img/icons/plus.svg" class="me-1" alt="img">Ku Dar Xaafad
                                                </a>
                                            </div>
                                            <div class="table-responsive">
                                                <table class="table  " id="xafada">
                                                    <thead>
                                                        <tr>

                                                            <th>Xaafada uu Hadda Ka Shaqeeyo</th>
                                                            <th>WaaxDa</th>
                                                            <th>Waqtiga Loo Lagu Qoray</th>
                                                            <th>Ficil</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Tab 2 -->
                                <div class="tab-pane fade" id="tab2-content" role="tabpanel" aria-labelledby="tab2-tab">
                                    <button class="btn btn-outline-success w-100 mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTab2" aria-expanded="false" aria-controls="collapseTab2">
                                        Show/Hide User Info
                                    </button>
                                    <div class="collapse" id="collapseTab2">
                                        <div class="card card-body border-success">
                                        
                                             <div class="modal-body">
                    <!-- Full Name -->
        <div class="form-group">
          <label for="fullname" class="form-label">Full Name</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-user"></i></span>
            <input type="text" class="form-control" id="fullname1" name="fullname" required>
          </div>
        </div>
       
                    <!-- Full Name -->
        <div class="form-group">
          <label for="fullname" class="form-label">Position</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-user"></i></span>
            <input type="text" class="form-control" id="position1" name="fullname" required>
          </div>
        </div>
               
            <div class="form-group">
  <label for="amount" class="form-label">Salary</label>
  <div class="input-group">
    <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
    <input type="number" class="form-control" id="salary1" name="amount" required>
  </div>
</div>

             
          

  

    
           

            <!-- Is Active -->
            <div class="form-group">
              <label for="isActive" class="form-label">Is Active</label>
              <select class="form-select" id="isActive1" name="isActive" required>
                <option value="1">Yes</option>
                <option value="0">No</option>
              </select>
            </div>
              <!-- Date -->
        <div class="form-group">
          <label for="date" class="form-label">Date</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
            <input type="date" class="form-control" id="date1" name="date" required>
          </div>
        </div>
    

            <!-- Phone Number -->
            <div class="form-group">
              <label for="number" class="form-label">Phone Number</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                <input type="text" class="form-control" id="number1" name="number" required>
              </div>
            </div>
  
        </div>
                                                 <div class="modal-footer">
    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary" id="edituser">Edit User</button>
  </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Tab 3 -->
                                <div class="tab-pane fade" id="tab3-content" role="tabpanel" aria-labelledby="tab3-tab">
                                    <button class="btn btn-outline-warning w-100 mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTab3" aria-expanded="false" aria-controls="collapseTab3">
                                        Show/Hide username and passoword
                                    </button>
                                    <div class="collapse" id="collapseTab3">
                                        <div class="card card-body border-warning">
                                                                                  <div class="modal-body">
      
                 <!-- Full Name -->
        <div class="form-group">
          <label for="fullname" class="form-label">UserName</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-user"></i></span>
            <input type="text" class="form-control" id="username1" name="fullname" required>
          </div>
        </div>
    
               
  

                      <!-- Street -->
          <div class="form-group">
            <label for="street" class="form-label">Password</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fas fa-road"></i></span>
              <input type="text" class="form-control" id="pass1" name="street" required>
            </div>
          </div>
          

        <div class="form-group">
          <label for="itemdrop" class="form-label">User Role</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
            <select class="form-select" id="userole1" name="subNeighborhoodID" required>
              <option selected="selected" value="0">Please select</option>
                             <option  value="Admin">Admin</option>
                 <option  value="Employee">Employee</option>
       <option  value="ShareHolder">ShareHolder</option>
              <!-- Options will be populated dynamically -->
            </select>
          </div>
        </div>

  

    
           

         
  
        </div>
                                                 <div class="modal-footer">
    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary" id="edituser1">Edit User</button>
  </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!-- End of Tab Content -->

                        </div>
                    </div>

                </div>
           
            </div>
        </div>
    </div>


    <%--    this is the modal--%>

    <!-- Modal -->
    <div class="modal fade" id="catmodal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Xaadada ku dar , kana badal xog</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="page-header">
                        <div class="page-title">
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-lg-6 col-sm-6 col-12">
                                    <div class="form-group">
                                        <input hidden type="text" id="id">
                                        <label>Magaca Xaafada</label>
                                        <input type="text" id="catname">
                                        <small id="nameError" class="text-danger"></small>
                                    </div>
                                </div>


                                <div class="col-lg-12">
                                    <a href="javascript:void(0);" id="deletebtn" class="btn btn-submit me-2" onclick="deletecategory()">delete</a>
                                    <a href="javascript:void(0);" id="editbtn" class="btn btn-submit me-2" onclick="updatexafad()">edit</a>
                                    <a href="javascript:void(0);" id="submitbtn" class="btn btn-submit me-2" onclick="submitxafad()">Submit</a>
                                    <a href="categorylist.html" class="btn btn-cancel" data-bs-dismiss="modal">Cancel</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Understood</button>
      </div>--%>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-lg-12 col-md-12">
            <div class="page-header">
                <div class="page-title">
                    <h4> Qeybta  Shaqaalaha </h4>

                </div>
                <div class="page-btn">
                    <a href="#" class="btn btn-added" id="openHouseModal">
                        <img src="assets/img/icons/plus.svg" class="me-1" alt="img">Add User
                    </a>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
           










                    <div class="table-responsive">
                        <table class="table  " id="datatable">
                            <thead>
                                <tr>

                                    <th>fullname</th>
                                    <th>UserRole</th>
                                    <th>Position</th>
                                    <th>Salary</th>
                                    <th>Username</th>
                                    <th>PasswordHash</th>
                                                 <th>Number</th>
                                                  <th>Status</th>
                                    <th>Ficil</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>




















       <!-- Beautiful Horizontal Modal -->
  <div class="modal fade" id="houseModal" tabindex="-1" aria-labelledby="houseModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="houseModalLabel">Add New User</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
                    <!-- Full Name -->
        <div class="form-group">
          <label for="fullname" class="form-label">Full Name</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-user"></i></span>
            <input type="text" class="form-control" id="fullname" name="fullname" required>
          </div>
        </div>
                 <!-- Full Name -->
        <div class="form-group">
          <label for="fullname" class="form-label">UserName</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-user"></i></span>
            <input type="text" class="form-control" id="username" name="fullname" required>
          </div>
        </div>
                    <!-- Full Name -->
        <div class="form-group">
          <label for="fullname" class="form-label">Position</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-user"></i></span>
            <input type="text" class="form-control" id="position" name="fullname" required>
          </div>
        </div>
               
            <div class="form-group">
  <label for="amount" class="form-label">Salary</label>
  <div class="input-group">
    <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
    <input type="number" class="form-control" id="salary" name="amount" required>
  </div>
</div>

                      <!-- Street -->
          <div class="form-group">
            <label for="street" class="form-label">Password</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fas fa-road"></i></span>
              <input type="text" class="form-control" id="pass" name="street" required>
            </div>
          </div>
          

        <div class="form-group">
          <label for="itemdrop" class="form-label">User Role</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
            <select class="form-select" id="userole" name="subNeighborhoodID" required>
              <option selected="selected" value="0">Please select</option>
                            <option  value="Admin">Admin</option>
                                <option  value="Employee">Employee</option>
                      <option  value="ShareHolder">ShareHolder</option>
              <!-- Options will be populated dynamically -->
            </select>
          </div>
        </div>

  

    
           

            <!-- Is Active -->
            <div class="form-group">
              <label for="isActive" class="form-label">Is Active</label>
              <select class="form-select" id="isActive" name="isActive" required>
                <option value="1">Yes</option>
                <option value="0">No</option>
              </select>
            </div>
              <!-- Date -->
        <div class="form-group">
          <label for="date" class="form-label">Date</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
            <input type="date" class="form-control" id="date" name="date" required>
          </div>
        </div>
    

            <!-- Phone Number -->
            <div class="form-group">
              <label for="number" class="form-label">Phone Number</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                <input type="text" class="form-control" id="number" name="number" required>
              </div>
            </div>
   
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary" id="saveHouseButton">Save User</button>
        </div>
      </div>
    </div>
  </div>






















    <script src="assets/js/jquery-3.6.0.min.js"></script>
    <script src="assets/js/jquery.dataTables.min.js"></script>
    <script src="assets/js/dataTables.bootstrap4.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#saveHouseButton').on('click', function () {
                try {
                    // Validate the fields before submitting
                    var isValid = validateForm();

                    if (isValid) {
                        var houseData = {

                            pass: $('#pass').val(),
                            username: $('#username').val(),
                            position: $('#position').val(),
                            userrole: $('#userole').val(),
                            isActive: $('#isActive').val(),
                            fullname: $('#fullname').val(),
                            number: $('#number').val(),
                            salary: $('#salary').val(),
                            date: $('#date').val()
                        };

                        console.log(houseData);
                        // Make AJAX call to save data to the server
                        $.ajax({
                            type: "POST",
                            url: "users.aspx/saveusers",
                            data: JSON.stringify(houseData),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                try {
                                    // Check if the response contains a success message
                                    if (response.d === "Success") {
                                        alert("User details saved successfully!");
                                        datadisplay();
                                    } else {
                                        // Display the error message returned from the server
                                        alert("Error: " + response.d);
                                        // Display the error message from the server in the console
                                        console.error("Error from server: " + response.d);
                                        alert("Failed to save house details: " + response.d);
                                    }
                                } catch (ex) {
                                    // Handle any exception during the success processing
                                    console.error("Success handler error: ", ex);
                                    alert("An unexpected error occurred while processing the response.");
                                }
                            },
                            error: function (xhr, status, error) {
                                try {
                                    // Log detailed error information for debugging
                                    console.error("Error details: ", error);
                                    console.error("Response text: ", xhr.responseText);
                                    alert("Failed to save the house details. Error: " + error + "\nDetails: " + xhr.responseText);
                                } catch (ex) {
                                    // Handle any exception during the error processing
                                    console.error("Error handler exception: ", ex);
                                    alert("An error occurred while processing the failure response.");
                                }
                            }
                        });
                    } else {
                        alert("Please fill all required fields correctly.");
                    }
                } catch (ex) {
                    // Catch any unexpected errors in the overall execution
                    console.error("Unexpected error: ", ex);
                    alert("An unexpected error occurred: " + ex.message);
                }
            });

            // Function to validate the form
            function validateForm() {
                var isValid = true;

                // Validate each required field
                if ($('#pass').val() === "") {
                    $('#pass').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#pass').removeClass('is-invalid');
                }

                if ($('#userrole').val() === "0") { // Ensure that an item is selected
                    $('#userrole').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#userrole').removeClass('is-invalid');
                }

                if ($('#waxda').val() === "0") { // Ensure that a waaxda is selected
                    $('#waxda').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#waxda').removeClass('is-invalid');
                }

                if ($('#salary').val() === "" || $('#salary').val() <= 0) {
                    $('#salary').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#salary').removeClass('is-invalid');
                }

                if ($('#username').val() === "") {
                    $('#username').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#username').removeClass('is-invalid');
                }

                if ($('#position').val() === "") {
                    $('#position').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#position').removeClass('is-invalid');
                }

                if ($('#state').val() === "") {
                    $('#state').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#state').removeClass('is-invalid');
                }

                if ($('#date').val() === "") {
                    $('#date').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#date').removeClass('is-invalid');
                }

                if ($('#postalCode').val() === "") {
                    $('#postalCode').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#postalCode').removeClass('is-invalid');
                }

                if ($('#fullname').val() === "") {
                    $('#fullname').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#fullname').removeClass('is-invalid');
                }

                if ($('#number').val() === "") {
                    $('#number').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#number').removeClass('is-invalid');
                }

                return isValid;
            }
        });




        $(document).ready(function () {
            $('#openHouseModal').click(function () {
                $('#houseModal').modal('show');
            });
        });

        datadisplay();
        function datadisplay() {
            $.ajax({
                url: 'users.aspx/datadisplay',
                dataType: "json",
                type: 'POST',
                contentType: "application/json",
                success: function (response) {
                    console.log(response)


                    $("#datatable tbody").empty();

                    for (var i = 0; i < response.d.length; i++) {
                        var Username = response.d[i].Username;
                        var PasswordHash = response.d[i].PasswordHash;
                        var UserRole = response.d[i].UserRole;
                        var fullname = response.d[i].fullname;
                        var Position = response.d[i].Position;
                        var Salary = response.d[i].Salary;
                        var EmployeeID = response.d[i].EmployeeID;
                        var UserID = response.d[i].UserID;
                        var number = response.d[i].number;
                        var isactive = response.d[i].isactive;
                        var date = response.d[i].date;
      

                        var statusText = (isactive === "True") ? "Active" : "Inactive";




                        $("#datatable tbody").append(
                            "<tr>" +

                            "<td>" + fullname + "</td>" +
                            "<td>" + UserRole + "</td>" +
                            "<td>" + Position + "</td>" +
                            "<td>" + Salary + "</td>" +
                            "<td>" + Username + "</td>" +
                            "<td>" + PasswordHash + "</td>" +
                            "<td>" + number + "</td>" +
                            "<td>" + statusText + "</td>" +
                            "<td style='display:none'>" + date + "</td>" +
                            "<td style='display:none'>" + UserID + "</td>" +
                            "<td>" +
                            '<a class="me-3 edit-button" data-id="' + EmployeeID + '">' +
                            '<img src="assets/img/icons/edit.svg" alt="Edit">' +
                            '</a>' +
                       
                            "</td>" +
                            "</tr>"
                        );
                    }


                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }





        $("#datatable").on("click", ".edit-button", function (event) {
            event.preventDefault(); // Prevent default behavior

            var row = $(this).closest("tr");
            var id = $(this).data("id");


            $("#id6").val(id);


            var userid = row.find("td:nth-child(10)").text();


            $("#id7").val(userid);

            var name = row.find("td:nth-child(1)").text();
            var position = row.find("td:nth-child(3)").text();
            var salary = row.find("td:nth-child(4)").text();
            var number = row.find("td:nth-child(7)").text();




            var user = row.find("td:nth-child(5)").text();
            var pasas = row.find("td:nth-child(6)").text();



            var stats = row.find("td:nth-child(8)").text();


            $("#isActive1").val(stats);

            // Set the value based on the text
            if (stats === "Active") {
                $("#isActive1").val("1").change(); // Sets value to 1 (Yes)
            } else if (stats === "Inactive") {
                $("#isActive1").val("0").change(); // Sets value to 0 (No)
            }


            var role = row.find("td:nth-child(2)").text();
            $("#userole1").val(role).change();





            $("#username1").val(user);
            $("#pass1").val(pasas);



            
            $("#id").val(id);
   


            $("#fullname1").val(name);
            $("#position1").val(position);

            $("#salary1").val(salary);


            $("#salary1").val(salary);

            $("#number1").val(number);


            var date = row.find("td:nth-child(9)").text(); // Get the full date text

  

            // Extract the date part before the space
            var formattedDate = date.split(" ")[0]; // "11/9/2024"

            // Convert the date to YYYY-MM-DD format for the input element
            var parts = formattedDate.split("/"); // Split by "/"
            var reformattedDate = parts[2] + "-" + parts[0].padStart(2, '0') + "-" + parts[1].padStart(2, '0');

            // Set the date input value
            $("#date1").val(reformattedDate);
            

































            document.getElementById('submitbtn').style.display = 'none';
            document.getElementById('editbtn').style.display = 'inline-block';
            document.getElementById('deletebtn').style.display = 'none';

            $.ajax({
                url: 'users.aspx/datadisplay1',
                data: "{'id':'" + id + "' }",
                dataType: "json",
                type: 'POST',
                contentType: "application/json",
                success: function (response) {
                    console.log(response)


                    $("#shaqale tbody").empty();

                    for (var i = 0; i < response.d.length; i++) {
                        var Username = response.d[i].Username;
                        var PasswordHash = response.d[i].PasswordHash;
                        var UserRole = response.d[i].UserRole;
                        var fullname = response.d[i].fullname;
                        var Position = response.d[i].Position;
                        var Salary = response.d[i].Salary;
                        var EmployeeID = response.d[i].EmployeeID;
                        var UserID = response.d[i].UserID;

                        var number = response.d[i].number;
                        var isactive = response.d[i].isactive;
                        var date = response.d[i].date;


                        var statusText = (isactive === "True") ? "Active" : "Inactive";







                        $("#shaqale tbody").append(
                            "<tr>" +

                            "<td>" + fullname + "</td>" +
                            "<td>" + UserRole + "</td>" +
                            "<td>" + Position + "</td>" +
                            "<td>" + Salary + "</td>" +
                            "<td>" + Username + "</td>" +
                            "<td>" + PasswordHash + "</td>" +
                            "<td>" + number + "</td>" +
                            "<td>" + date + "</td>" +
                            "<td>" + statusText + "</td>" +
                            "</tr>"
                        );
                    }


                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
            kashaqeyn();
            function kashaqeyn() {
                $.ajax({
                    url: 'users.aspx/datadisplay2',
                    data: "{'id':'" + id + "' }",
                    dataType: "json",
                    type: 'POST',
                    contentType: "application/json",
                    success: function (response) {
                        console.log(response)


                        $("#xafada tbody").empty();

                        for (var i = 0; i < response.d.length; i++) {
                            var SubNeighborhoodName = response.d[i].SubNeighborhoodName;
                            var NeighborhoodName = response.d[i].NeighborhoodName;
                            var AssignmentDate = response.d[i].AssignmentDate;
                            var AssignmentID = response.d[i].AssignmentID;








                            $("#xafada tbody").append(
                                "<tr>" +

                                "<td>" + NeighborhoodName + "</td>" +
                                "<td>" + SubNeighborhoodName + "</td>" +
                                "<td>" + AssignmentDate + "</td>" +

                                "<td>" +
                                '<a class="me-3 edit-button" data-id="' + AssignmentID + '">' +
                                '<img src="assets/img/icons/edit.svg" alt="Edit">' +
                                '</a>' +
                                '<a class="me-3 delete-btn" data-id="' + AssignmentID + '">' +
                                '<img src="assets/img/icons/delete.svg" alt="Delete">' +
                                '</a>' +
                                "</td>" +
                                "</tr>"
                            );
                        }


                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }


            $('#stockmodal').modal('show');


            $("#xafada").on("click", ".edit-button", function (event) {
                event.preventDefault(); // Prevent default behavior

                var row = $(this).closest("tr");
                var id = $(this).data("id");


                var name = row.find("td:nth-child(2)").text();

                $("#id1").val(id);
                $("#wax").val(name);

                document.getElementById('submitbtn1').style.display = 'none';
                document.getElementById('editbtn1').style.display = 'none';
                document.getElementById('editbtn11').style.display = 'inline-block';
                document.getElementById('deletebtn1').style.display = 'none';
                $('#stockmodal').modal('hide');
                $('#xafadamodal').modal('show');



            });


            $("#xafada").on("click", ".delete-btn", function (event) {
                event.preventDefault(); // Prevent default behavior

                var row = $(this).closest("tr");
                var id = $(this).data("id");



                // Clear previous error messages

                Swal.fire({
                    title: 'Ma Hubtaa ?',
                    text: "Ma Rabtaa Inaad Delete Gareeneyso ?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, start it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Execute the AJAX request only if the user confirms
                        $.ajax({
                            url: 'users.aspx/deletexafadashaqo',
                            data: "{'id':'" + id + "'}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            type: 'POST',
                            success: function (response) {
                                console.log(response);
                                if (response.d === 'true') {
                                    Swal.fire(
                                        'Successfully Deleted!',
                                        'You Deleted a xafada uu ku qornaa!',
                                        'success'
                                    );
                                    kashaqeyn();
                                    $('#xafadamodal').modal('hide');
                                    $('#stockmodal').modal('show');
                                    datadisplay();
                                } else {
                                    // Handle errors in the response
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Data Insertion Failed',
                                        text: 'There was an error while inserting the stock data: ' + response.d,
                                    });
                                }
                            },
                            error: function (response) {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'AJAX Error',
                                    text: 'An error occurred during the AJAX request: ' + response.responseText,
                                });
                            }
                        });
                    }
                });



            });



        });







        //pass: $('#pass').val(),
        //    username: $('#username').val(),
        //        position: $('#position').val(),
        //            userrole: $('#userole').val(),
        //                isActive: $('#isActive').val(),
        //                    fullname: $('#fullname').val(),
        //                        number: $('#number').val(),
        //                            salary: $('#salary').val(),
        //                                date: $('#date').val()






        $(document).ready(function () {
            $('#edituser').on('click', function () {



                var isActiveValue = $('#isActive1').val() === "1";
                try {
                    // Validate the fields before submitting
                    var isValid = validateForm();

                    if (isValid) {
                        var userdata = {
                         
                            salary: $('#salary1').val(),
                          


                            isActive: isActiveValue,



                            fullname: $('#fullname1').val(),
                            number: $('#number1').val(),
                            position: $('#position1').val(),
                            date: $('#date1').val(),
                            id: $('#id6').val()

                        };

                        console.log(userdata);
                        // Make AJAX call to save data to the server
                        $.ajax({
                            type: "POST",
                            url: "users.aspx/updateusers",
                            data: JSON.stringify({ userdata: userdata }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                try {
                                    // Check if the response contains a success message
                                    if (response.d === "Success") {
                                        alert("User details Updated successfully!");

                                        $('#stockmodal').modal('hide');
                                    } else {
                                        // Display the error message returned from the server
                                        console.error("Error from server: " + response.d);
                                        alert("Failed to save house details: " + response.d);
                                    }
                                } catch (ex) {
                                    // Handle any exception during the success processing
                                    console.error("Success handler error: ", ex);
                                    alert("An unexpected error occurred while processing the response.");
                                }
                            },
                            error: function (xhr, status, error) {
                                try {
                                    // Log the main error message
                                    console.error("AJAX error:", error);

                                    // Check if there is a response from the server with more details
                                    if (xhr.responseText) {
                                        console.error("Server response text:", xhr.responseText);

                                        // Attempt to parse the server response if it's in JSON format
                                        try {
                                            const responseJson = JSON.parse(xhr.responseText);
                                            if (responseJson && responseJson.Message) {
                                                console.error("Specific error from server:", responseJson.Message);
                                            }
                                        } catch (parseError) {
                                            console.error("Could not parse server response as JSON:", parseError);
                                        }
                                    } else {
                                        console.error("No response text from the server.");
                                    }
                                } catch (ex) {
                                    console.error("Exception during error handling:", ex);
                                }
                            }

                        });
                    }
                } catch (ex) {
                    console.error("Button click handler exception: ", ex);
                    alert("An unexpected error occurred.");
                }
            });
       

            // Function to validate the form
            function validateForm() {
                var isValid = true;

                // Validate each required field
                if ($('#salary1').val() === "") {
                    $('#salary1').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#salary1').removeClass('is-invalid');
                }

             

                if ($('#date1').val() === "") {
                    $('#date1').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#date1').removeClass('is-invalid');
                }

                if ($('#number1').val() === "") {
                    $('#number1').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#number1').removeClass('is-invalid');
                }

                if ($('#fullname1').val() === "") {
                    $('#fullname1').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#fullname1').removeClass('is-invalid');
                }
                if ($('#position1').val() === "") {
                    $('#position1').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#position1').removeClass('is-invalid');
                }

                return isValid;
            }

        });




































        $(document).ready(function () {
            $('#edituser1').on('click', function () {




                try {
                    // Validate the fields before submitting
                    var isValid = validateForm();

                    if (isValid) {
                        var userdetails = {

                            username: $('#username1').val(),
                              pass: $('#pass1').val(),
                            userole: $('#userole1').val(),
                   id: $('#id7').val()

                        };

                        console.log(userdetails);
                        // Make AJAX call to save data to the server
                        $.ajax({
                            type: "POST",
                            url: "users.aspx/updateusername",
                            data: JSON.stringify({ userdetails: userdetails }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                try {
                                    // Check if the response contains a success message
                                    if (response.d === "Success") {
                                        alert("User details Updated successfully!");
                                        datadisplay();
                                        $('#stockmodal').modal('hide');
                                    } else {
                                        // Display the error message returned from the server
                                        console.error("Error from server: " + response.d);
                                        alert("Failed to save house details: " + response.d);
                                    }
                                } catch (ex) {
                                    // Handle any exception during the success processing
                                    console.error("Success handler error: ", ex);
                                    alert("An unexpected error occurred while processing the response.");
                                }
                            },
                            error: function (xhr, status, error) {
                                try {
                                    // Log the main error message
                                    console.error("AJAX error:", error);

                                    // Check if there is a response from the server with more details
                                    if (xhr.responseText) {
                                        console.error("Server response text:", xhr.responseText);

                                        // Attempt to parse the server response if it's in JSON format
                                        try {
                                            const responseJson = JSON.parse(xhr.responseText);
                                            if (responseJson && responseJson.Message) {
                                                console.error("Specific error from server:", responseJson.Message);
                                            }
                                        } catch (parseError) {
                                            console.error("Could not parse server response as JSON:", parseError);
                                        }
                                    } else {
                                        console.error("No response text from the server.");
                                    }
                                } catch (ex) {
                                    console.error("Exception during error handling:", ex);
                                }
                            }

                        });
                    }
                } catch (ex) {
                    console.error("Button click handler exception: ", ex);
                    alert("An unexpected error occurred.");
                }
            });




            // Function to validate the form
            function validateForm() {
                var isValid = true;

                // Validate each required field
                if ($('#pass1').val() === "") {
                    $('#pass1').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#pass1').removeClass('is-invalid');
                }



          
                if ($('#username1').val() === "") {
                    $('#username1').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#username1').removeClass('is-invalid');
                }
                if ($('#userole1').val() === "") {
                    $('#userole1').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#userole1').removeClass('is-invalid');
                }

                return isValid;
            }

        });


















































        function badalwaax() {




            var waxda = $("#itemdwaxdarop").val();


            var id = $("#id1").val();




            $.ajax({
                url: 'users.aspx/badalxafad',
                data: "{'id':'" + id + "', 'waxda':'" + waxda + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                type: 'POST',
                success: function (response) {
                    console.log(response);

                    if (response.d === 'true') {
                        Swal.fire(
                            'Successfully Saved!',
                            'You added a new Xaafad!',
                            'success'
                        );

                        $('#xafadamodal').modal('hide');

                        $('#stockmodal').modal('show');

                    } else {
                        // Handle errors in the response
                        Swal.fire({
                            icon: 'error',
                            title: 'Data Insertion Failed',
                            text: 'There was an error while inserting the data.',
                        });
                    }
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });




        }
        $(document).ready(function () {
            $('#itemdrop').change(function () {
                var search = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "users.aspx/getwax",
                    data: "{'search':'" + search + "' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var waxda = $("[id*=waxda]");
                        waxda.empty().append('<option selected="selected" value="0">Please select</option>');
                        $.each(r.d, function () {
                            waxda.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }
                });
            });
        });

        getxafad();

        function getxafad() {
            $.ajax({
                type: "POST",
                url: "crudneighbourhoods.aspx/getxafad",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var itemdrop = $("[id*=itemdrop]");
                    itemdrop.empty().append('<option selected="selected" value="0">Please select</option>');
                    $.each(r.d, function () {
                        itemdrop.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        }


        function callmodal() {

            document.getElementById('submitbtn1').style.display = 'inline-block';
            document.getElementById('editbtn1').style.display = 'none';
            document.getElementById('editbtn11').style.display = 'none';
            document.getElementById('deletebtn1').style.display = 'none';
            $("#catname").val('');
            $('#stockmodal').modal('hide');
            $('#xafadamodal').modal('show');

        }

        function kudarxafad() {




            var waxda = $("#itemdwaxdarop").val();


            var id = $("#id").val();




            $.ajax({
                url: 'users.aspx/kudarxafad',
                data: "{'id':'" + id + "', 'waxda':'" + waxda + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                type: 'POST',
                success: function (response) {
                    console.log(response);

                    if (response.d === 'true') {
                        Swal.fire(
                            'Successfully Saved!',
                            'You added a new Xaafad uu ka shaqeeyo!',
                            'success'
                        );

                        $('#xafadamodal').modal('hide');

                        $('#stockmodal').modal('show');

                    } else {
                        // Handle errors in the response
                        Swal.fire({
                            icon: 'error',
                            title: 'Data Insertion Failed',
                            text: 'There was an error while inserting the data.',
                        });
                    }
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });




        }

    </script>
</asp:Content>

