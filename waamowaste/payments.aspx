<%@ Page Title="" Language="C#" MasterPageFile="~/home.Master" AutoEventWireup="true" CodeBehind="payments.aspx.cs" Inherits="waamowaste.payments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card {
  transition: transform 0.2s ease-in-out;
}

.card:hover {
  transform: translateY(-10px);
}

.card-title {
  font-weight: bold;
}

.display-6 {
  font-size: 2rem;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container-fluid">
    <div class="row">
        <!-- Left Section: Employee Data -->
        <div class="col-lg-8 col-md-12">
            <div class="page-header">
                <div class="page-title">
                    <h4>Magacyada Shaqaalaha</h4>
                    <div class="col-lg-12 col-sm-12 col-12 mt-2">
                        <div class="form-group">
                            <select class="form-select" id="getdate">
                    
                            </select>
                        </div>
                    </div>
                </div>
           
            </div>

            <div class="card">
                <div class="card-body">
                    <!-- Filter and Export Section -->
                    <div class="table-top d-flex justify-content-between align-items-center mb-3">
                        <div class="search-set d-flex">
                            <div class="search-path">
                                <a class="btn btn-light" id="filter_search">
                                    <img src="assets/img/icons/filter.svg" alt="img">
                                    <span>
                                        <img src="assets/img/icons/closes.svg" alt="img">
                                    </span>
                                </a>
                            </div>
                            <div class="search-input ms-2">
                                <a class="btn btn-primary">
                                    <img src="assets/img/icons/search-white.svg" alt="img">
                                </a>
                            </div>
                        </div>
                        <div class="wordset d-flex">
                            <ul class="list-inline">
                                <li class="list-inline-item">
                                    <a data-bs-toggle="tooltip" data-bs-placement="top" title="PDF">
                                        <img src="assets/img/icons/pdf.svg" alt="img">
                                    </a>
                                </li>
                                <li class="list-inline-item">
                                    <a data-bs-toggle="tooltip" data-bs-placement="top" title="Excel">
                                        <img src="assets/img/icons/excel.svg" alt="img">
                                    </a>
                                </li>
                                <li class="list-inline-item">
                                    <a data-bs-toggle="tooltip" data-bs-placement="top" title="Print">
                                        <img src="assets/img/icons/printer.svg" alt="img">
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Filter Inputs -->
                    <div class="card" id="filter_inputs">
                        <div class="card-body pb-0">
                            <div class="row">
                                <div class="col-lg-3 col-md-6 col-12 mb-2">
                                    <div class="form-group">
                                        <select class="form-select">
                                            <option>Choose Category</option>
                                            <option>Computers</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-12 mb-2">
                                    <div class="form-group">
                                        <select class="form-select">
                                            <option>Choose Sub Category</option>
                                            <option>Fruits</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-12 mb-2">
                                    <div class="form-group">
                                        <select class="form-select">
                                            <option>Choose Sub Brand</option>
                                            <option>Iphone</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-12 mb-2">
                                    <a class="btn btn-primary w-100">
                                        <img src="assets/img/icons/search-whites.svg" alt="img">
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Table Section -->
                    <div class="table-responsive">
                        <table class="table table-hover table-striped" id="datatable">
                            <thead class="table-info">
                                <tr>
                                    <th>Full Name</th>
                                    <th>Guri Number</th>
                                    <th>Xafada</th>
                                    <th>Waaxda</th>
                                    <th>Number Ka</th>
                                    <th>Lacagta</th>
                                    <th>Lacagta Deynta</th>
                                      <th>Xaalada</th>
                                    <th>Ficil</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Dynamic rows will be inserted here -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Section: Summary Cards -->
        <div class="col-lg-4 col-md-12 mt-3 mt-lg-0">
            <div class="row text-center">
                <!-- Total Amount Card -->
                <div class="col-lg-12 col-md-6 mb-4">
                    <div class="card shadow-sm border-0 rounded">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase">Total Amount</h5>
                            <h3 id="ta" class="display-6 text-primary">$0.00</h3>
                        </div>
                    </div>
                </div>

                <!-- Total Due Amount Card -->
                <div class="col-lg-12 col-md-6 mb-4">
                    <div class="card shadow-sm border-0 rounded">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase">Total Due Amount</h5>
                            <h3 id="td" class="display-6 text-danger">$0.00</h3>
                        </div>
                    </div>
                </div>

                <!-- Total Difference Card -->
                <div class="col-lg-12 col-md-6 mb-4">
                    <div class="card shadow-sm border-0 rounded">
                        <div class="card-body">
                            <h5 class="card-title text-uppercase">Total Difference</h5>
                            <h3 id="tdiff" class="display-6 text-warning">$0.00</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

    
    <script src="assets/js/jquery-3.6.0.min.js"></script>
    <script src="assets/js/jquery.dataTables.min.js"></script>
    <script src="assets/js/dataTables.bootstrap4.min.js"></script>

    <script>
        $(document).ready(function () {
            // When the first dropdown changes
            $('#getdate').change(function () {
                var search = $(this).val();

       
                $.ajax({
                    url: 'payments.aspx/datadisplay',
                    data: "{'search':'" + search + "' }",
                    dataType: "json",
                    type: 'POST',
                    contentType: "application/json",
                    success: function (response) {
                        console.log(response)


                        $("#datatable tbody").empty();

                        for (var i = 0; i < response.d.length; i++) {
                            var NeighborhoodName = response.d[i].NeighborhoodName;
                            var SubNeighborhoodName = response.d[i].SubNeighborhoodName;
                            var HouseNumber = response.d[i].HouseNumber;
                         

                            var fullname = response.d[i].fullname;
                            var number = response.d[i].number;
           
                            var amount = response.d[i].amount;
                            var DueAmount = response.d[i].DueAmount;
                            var PaymentStatusID = response.d[i].PaymentStatusID;






                            //// Determine button label based on DueAmount
                            //var paymentButton = (DueAmount == 0)
                            //    ? '<button class="btn btn-success" type="button">Paid</button>'
                            //    : '<button class="btn btn-danger" type="button">Not Paid</button>';





                            // Determine button label based on DueAmount
                            var paymentButton;
                            if (DueAmount == 0) {
                                paymentButton = '<button class="btn btn-success" type="button">Paid</button>';
                            } else if (DueAmount > 0 && DueAmount < amount) {
                                paymentButton = '<button class="btn btn-warning" type="button">Half Paid</button>';
                            } else {
                                paymentButton = '<button class="btn btn-danger" type="button">Not Paid</button>';
                            }



                            $("#datatable tbody").append(
                                "<tr>" +

                                "<td>" + fullname + "</td>" +
                                "<td>" + HouseNumber + "</td>" +
                                "<td>" + NeighborhoodName + "</td>" +
                                "<td>" + SubNeighborhoodName + "</td>" +
                                "<td>" + number + "</td>" +
                                "<td>" + amount + "</td>" +
                                "<td>" + DueAmount + "</td>" +
                                "<td>" + paymentButton + "</td>" +
                                                               "<td>" +
                                '<button class="btn btn-success me-3 edit-button" data-id="' + PaymentStatusID + '" type="button">' +
                                'View House' +
                                '</button>' +
                                "</td>"
                                +
                                "</tr>"
                            );
                        }


                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });


                $.ajax({
                    type: "POST",
                    url: "payments.aspx/money",
                    data: "{'search':'" + search + "'} ",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        console.log(r);
                        var earnings = r.d;

                        // Check if values are valid numbers and convert if necessary
                        var TotalAmount = parseFloat(earnings[0].TotalAmount) || 0;
                        var TotalDueAmount = parseFloat(earnings[0].TotalDueAmount) || 0;
                        var TotalDifference = parseFloat(earnings[0].TotalDifference) || 0;

                        // Update the HTML elements with formatted numbers
                        $("#ta").text('$' + TotalAmount.toFixed(2));
                        $("#td").text('$' + TotalDueAmount.toFixed(2));
                        $("#tdiff").text('$' + TotalDifference.toFixed(2));
                    },
                    error: function (xhr, status, error) {
                        console.error(xhr.responseText);
                    }
                });


            });
        });


        $(document).ready(function () {



            $(function () {


                $.ajax({
                    type: "POST",
                    url: "payments.aspx/getdate",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var getdate = $("[id*=getdate]");
                        getdate.empty().append('<option selected="selected" value="0">Please select</option>');
                        $.each(r.d, function () {
                            getdate.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }
                });



            });

        });


    </script>

</asp:Content>
