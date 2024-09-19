<%@ Page Title="" Language="C#" MasterPageFile="~/home.Master" AutoEventWireup="true" CodeBehind="users.aspx.cs" Inherits="waamowaste.users" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
        <input id="id1" style="display:none"/>
<div class="col-lg-4 col-sm-6 col-12" id="dropee">
<div class="form-group">
<label> Xaafada</label>
<select class="select" id="itemdrop">

</select>
       <small id="xafad1" class="text-danger"></small>
</div>
</div>

    <div class="col-lg-4 col-sm-6 col-12" id="dropee1">
<div class="form-group">
<label> Xaafada</label>
<select class="select" id="itemdwaxdarop">

</select>
       <small id="xafad13" class="text-danger"></small>
</div>
</div>

    

  


<div class="col-lg-12">
        <a href="javascript:void(0);" id="deletebtn1" class="btn btn-submit me-2" onclick="deletecategory()">delete</a>
    <a href="javascript:void(0);" id="editbtn1" class="btn btn-submit me-2" onclick="updateitemstock()">edit</a>
      <a href="javascript:void(0);" id="editbtn11" class="btn btn-submit me-2" onclick="badalwaax()">edit</a>
    
<a href="javascript:void(0);" id="submitbtn1" class="btn btn-submit me-2" onclick="submitwax()">Submit</a>
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

        <div class="page-header mb-3">
          <div class="page-title">
            <h4 class="text-center">Add Items to Stock</h4>
          </div>
        </div>

        <div class="card shadow-sm">
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
                <button class="nav-link" id="tab2-tab" data-bs-toggle="tab" data-bs-target="#tab2-content" type="button" role="tab" aria-controls="tab2-content" aria-selected="false">Supplier Info</button>
              </li>
              <li class="nav-item" role="presentation">
                <button class="nav-link" id="tab3-tab" data-bs-toggle="tab" data-bs-target="#tab3-content" type="button" role="tab" aria-controls="tab3-content" aria-selected="false">Purchase History</button>
              </li>
            </ul>

            <!-- Tab Content -->
            <div class="tab-content mt-4" id="myTabContent">

              <!-- Tab 1 -->
              <div class="tab-pane fade show active" id="tab1-content" role="tabpanel" aria-labelledby="tab1-tab">
                <button class="btn btn-outline-primary w-100 mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTab1" aria-expanded="false" aria-controls="collapseTab1">
                  Show/Hide Stock Details
                </button>
                <div class="collapse" id="collapseTab1">
                  <div class="card card-body border-primary">
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
                  Show/Hide Supplier Info
                </button>
                <div class="collapse" id="collapseTab2">
                  <div class="card card-body border-success">
                    <p>Provide supplier information here, including contact details, delivery options, and any additional notes regarding stock supplies.</p>
                    <!-- Add more content here for Tab 2 -->
                  </div>
                </div>
              </div>

              <!-- Tab 3 -->
              <div class="tab-pane fade" id="tab3-content" role="tabpanel" aria-labelledby="tab3-tab">
                <button class="btn btn-outline-warning w-100 mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTab3" aria-expanded="false" aria-controls="collapseTab3">
                  Show/Hide Purchase History
                </button>
                <div class="collapse" id="collapseTab3">
                  <div class="card card-body border-warning">
                    <p>View and manage the purchase history for this stock item, including previous purchase dates, quantities, and associated suppliers.</p>
                    <!-- Add more content here for Tab 3 -->
                  </div>
                </div>
              </div>

            </div>
            <!-- End of Tab Content -->

          </div>
        </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save Changes</button>
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
        <div class="col-lg-8 col-md-12">
            <div class="page-header">
<div class="page-title">
<h4>Magacyada Shaqaalaha </h4>

</div>
<div class="page-btn">
<a href="#" class="btn btn-added" onclick="callmodal()">
<img src="assets/img/icons/plus.svg" class="me-1" alt="img">Ku Dar Xaafad
</a>
</div>
</div>

<div class="card">
<div class="card-body">
<div class="table-top">
<div class="search-set">
<div class="search-path">
<a class="btn btn-filter" id="filter_search">
<img src="assets/img/icons/filter.svg" alt="img">
<span><img src="assets/img/icons/closes.svg" alt="img"></span>
</a>
</div>
<div class="search-input">
<a class="btn btn-searchset"><img src="assets/img/icons/search-white.svg" alt="img"></a>
</div>
</div>
<div class="wordset">
<ul>
<li>
<a data-bs-toggle="tooltip" data-bs-placement="top" title="pdf"><img src="assets/img/icons/pdf.svg" alt="img"></a>
</li>
<li>
<a data-bs-toggle="tooltip" data-bs-placement="top" title="excel"><img src="assets/img/icons/excel.svg" alt="img"></a>
</li>
<li>
<a data-bs-toggle="tooltip" data-bs-placement="top" title="print"><img src="assets/img/icons/printer.svg" alt="img"></a>
</li>
</ul>
</div>
</div>

<div class="card" id="filter_inputs">
<div class="card-body pb-0">
<div class="row">
<div class="col-lg-2 col-sm-6 col-12">
<div class="form-group">
<select class="select">
<option>Choose Category</option>
<option>Computers</option>
</select>
</div>
</div>
<div class="col-lg-2 col-sm-6 col-12">
<div class="form-group">
<select class="select">
<option>Choose Sub Category</option>
<option>Fruits</option>
</select>
</div>
</div>
<div class="col-lg-2 col-sm-6 col-12">
<div class="form-group">
<select class="select">
<option>Choose Sub Brand</option>
<option>Iphone</option>
</select>
</div>
</div>
<div class="col-lg-1 col-sm-6 col-12 ms-auto">
<div class="form-group">
<a class="btn btn-filters ms-auto"><img src="assets/img/icons/search-whites.svg" alt="img"></a>
</div>
</div>
</div>
</div>
</div>




    







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
         <div class="col-lg-4 col-md-12">
                         <div class="page-header">
<div class="page-title">
<h4>Magacyada Waaxyada </h4>

</div>
<div class="page-btn">
<a href="#" class="btn btn-added" onclick="callwaaxmodel()">
<img src="assets/img/icons/plus.svg" class="me-1" alt="img">Ku Dar waax
</a>
</div>
</div>

<div class="card">
<div class="card-body">
<div class="table-top">
<div class="search-set">
<div class="search-path">
<a class="btn btn-filter" id="filter_search1">
<img src="assets/img/icons/filter.svg" alt="img">
<span><img src="assets/img/icons/closes.svg" alt="img"></span>
</a>
</div>
<div class="search-input">
<a class="btn btn-searchset"><img src="assets/img/icons/search-white.svg" alt="img"></a>
</div>
</div>
<div class="wordset">
<ul>
<li>
<a data-bs-toggle="tooltip" data-bs-placement="top" title="pdf"><img src="assets/img/icons/pdf.svg" alt="img"></a>
</li>
<li>
<a data-bs-toggle="tooltip" data-bs-placement="top" title="excel"><img src="assets/img/icons/excel.svg" alt="img"></a>
</li>
<li>
<a data-bs-toggle="tooltip" data-bs-placement="top" title="print"><img src="assets/img/icons/printer.svg" alt="img"></a>
</li>
</ul>
</div>
</div>

<div class="card" id="filter_inputs1">
<div class="card-body pb-0">
<div class="row">
<div class="col-lg-2 col-sm-6 col-12">
<div class="form-group">
<select class="select">
<option>Choose Category</option>
<option>Computers</option>
</select>
</div>
</div>
<div class="col-lg-2 col-sm-6 col-12">
<div class="form-group">
<select class="select">
<option>Choose Sub Category</option>
<option>Fruits</option>
</select>
</div>
</div>
<div class="col-lg-2 col-sm-6 col-12">
<div class="form-group">
<select class="select">
<option>Choose Sub Brand</option>
<option>Iphone</option>
</select>
</div>
</div>
<div class="col-lg-1 col-sm-6 col-12 ms-auto">
<div class="form-group">
<a class="btn btn-filters ms-auto"><img src="assets/img/icons/search-whites.svg" alt="img"></a>
</div>
</div>
</div>
</div>
</div>

<div class="table-responsive">
<table class="table  " id="waax">
<thead>
<tr>

<th>Magaca Xaafada</th>
    <th>Magaca Waaxda</th>

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


        <script src="assets/js/jquery-3.6.0.min.js"></script>
    <script src="assets/js/jquery.dataTables.min.js"></script>
<script src="assets/js/dataTables.bootstrap4.min.js"></script>
    <script>

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

                        







                        $("#datatable tbody").append(
                            "<tr>" +

                            "<td>" + fullname + "</td>" +
                            "<td>" + UserRole + "</td>" +
                            "<td>" + Position + "</td>" +
                            "<td>" + Salary + "</td>" +
                            "<td>" + Username + "</td>" +
                            "<td>" + PasswordHash + "</td>" +
                            "<td>" +
                            '<a class="me-3 edit-button" data-id="' + EmployeeID + '">' +
                            '<img src="assets/img/icons/edit.svg" alt="Edit">' +
                            '</a>' +
                            '<a class="me-3 delete-btn" data-id="' + EmployeeID + '">' +
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


  


        $("#datatable").on("click", ".edit-button", function (event) {
            event.preventDefault(); // Prevent default behavior

            var row = $(this).closest("tr");
            var id = $(this).data("id");


            var name = row.find("td:nth-child(1)").text();

            $("#id").val(id);
            $("#catname").val(name);


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









                        $("#shaqale tbody").append(
                            "<tr>" +

                            "<td>" + fullname + "</td>" +
                            "<td>" + UserRole + "</td>" +
                            "<td>" + Position + "</td>" +
                            "<td>" + Salary + "</td>" +
                            "<td>" + Username + "</td>" +
                            "<td>" + PasswordHash + "</td>" +
                            "<td>" +
                            '<a class="me-3 edit-button" data-id="' + EmployeeID + '">' +
                            '<img src="assets/img/icons/edit.svg" alt="Edit">' +
                            '</a>' +
                            '<a class="me-3 delete-btn" data-id="' + EmployeeID + '">' +
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






    </script>
</asp:Content>
