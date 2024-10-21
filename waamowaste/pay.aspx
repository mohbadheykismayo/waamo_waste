<%@ Page Title="" Language="C#" MasterPageFile="~/home.Master" AutoEventWireup="true" CodeBehind="pay.aspx.cs" Inherits="waamowaste.pay" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Modal -->
<div class="modal fade" id="stockmodal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h1 class="modal-title fs-4" id="staticBackdropLabel1">Lacagta Bixi - Payment Details</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="card shadow-sm mb-4">
          <div class="card-body">
            <div class="row g-3">
              <input id="id1" type="hidden" />

              <div class="col-lg-4 col-sm-6">
                <div class="form-group">
                  <label for="amountRequired" class="form-label">Amount Required</label>
                  <input type="number" id="amountRequired" class="form-control" placeholder="Enter amount required" oninput="calculateRemaining()">
                  <small id="amountRequiredError" class="text-danger"></small>
                </div>
              </div>

              <div class="col-lg-4 col-sm-6">
                <div class="form-group">
                  <label for="creditAmount" class="form-label">Credit Amount</label>
                  <input type="number" id="creditAmount" class="form-control" placeholder="Enter credit amount" oninput="calculateRemaining()">
                  <small id="creditAmountError" class="text-danger"></small>
                </div>
              </div>

              <div class="col-lg-4 col-sm-6">
                <div class="form-group">
                  <label for="remainingAmount" class="form-label">Remaining Amount</label>
                  <input type="number" id="remainingAmount" class="form-control" placeholder="Remaining amount" readonly>
                  <small id="remainingAmountError" class="text-danger"></small>
                </div>
              </div>

              <div class="col-lg-12 text-center mt-3">
                <a href="javascript:void(0);" id="submitbtn1" class="btn btn-primary btn-lg me-2" onclick="submitlacag()">Submit</a>
                <a href="javascript:void(0);" class="btn btn-secondary btn-lg" data-bs-dismiss="modal">Cancel</a>
              </div>
            </div>
          </div>
        </div>

        <div class="card shadow-sm mt-4">
          <div class="card-header bg-secondary text-white">
            <h5>Entered Data Summary</h5>
          </div>
          <div class="card-body">
            <p><strong>Amount Required:</strong> <span id="displayAmountRequired"></span></p>
            <p><strong>Credit Amount:</strong> <span id="displayCreditAmount"></span></p>
            <p><strong>Remaining Amount:</strong> <span id="displayRemainingAmount"></span></p>
            <div class="text-center mt-4">
              <a href="javascript:void(0);" id="repayCreditBtn" class="btn btn-warning btn-lg" onclick="openRepayInput()">Repay Credit Amount</a>
            </div>

            <div id="repaySection" class="mt-4" style="display: none;">
              <div class="form-group">
                <label for="repayAmount" class="form-label">Repay Credit Amount</label>
                <input type="number" id="repayAmount" class="form-control" placeholder="Enter amount to repay">
                <small id="repayAmountError" class="text-danger"></small>
              </div>
              <div class="text-center mt-3">
                <a href="javascript:void(0);" id="submitRepayBtn" class="btn btn-success btn-lg" onclick="submitRepay()">Submit Repayment</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


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

                        <span id= "PaymentPeriodID" ></span>
    </div>
</div>

    
    <script src="assets/js/jquery-3.6.0.min.js"></script>
    <script src="assets/js/jquery.dataTables.min.js"></script>
    <script src="assets/js/dataTables.bootstrap4.min.js"></script>

    <script>
        function calculateRemaining() {
            const amountRequired = parseFloat(document.getElementById('amountRequired').value) || 0;
            const creditAmount = parseFloat(document.getElementById('creditAmount').value) || 0;
            const remainingAmount = amountRequired - creditAmount;
            document.getElementById('remainingAmount').value = remainingAmount > 0 ? remainingAmount : 0;
        }

        //function submitwax() {
        //    const amountRequired = document.getElementById('amountRequired').value;
        //    const creditAmount = document.getElementById('creditAmount').value;
        //    let isValid = true;

        //    if (!amountRequired) {
        //        document.getElementById('amountRequiredError').textContent = "Please enter the amount required.";
        //        isValid = false;
        //    } else {
        //        document.getElementById('amountRequiredError').textContent = "";
        //    }

        //    if (!creditAmount) {
        //        document.getElementById('creditAmountError').textContent = "Please enter the credit amount.";
        //        isValid = false;
        //    } else {
        //        document.getElementById('creditAmountError').textContent = "";
        //    }

        //    if (isValid) {
        //        // Proceed with submission logic
        //        console.log("Form submitted");
        //    }
        //}
        $(document).ready(function () {
            // When the first dropdown changes
            $('#getdate').change(function () {
                var search = $(this).val();
                $('#PaymentPeriodID').text(search);

                $.ajax({
                    url: 'pay.aspx/datadisplay',
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
           
                            //var amount = response.d[i].amount;
                            //var DueAmount = response.d[i].DueAmount;
                            var PaymentStatusID = response.d[i].PaymentStatusID;






                            //// Determine button label based on DueAmount
                            //var paymentButton = (DueAmount == 0)
                            //    ? '<button class="btn btn-success" type="button">Paid</button>'
                            //    : '<button class="btn btn-danger" type="button">Not Paid</button>';





                            //// Determine button label based on DueAmount
                            //var paymentButton;
                            //if (DueAmount == 0) {
                            //    paymentButton = '<button class="btn btn-success" type="button">Paid</button>';
                            //} else if (DueAmount > 0 && DueAmount < amount) {
                            //    paymentButton = '<button class="btn btn-warning" type="button">Half Paid</button>';
                            //} else {
                            //    paymentButton = '<button class="btn btn-danger" type="button">Not Paid</button>';
                            //}



                            $("#datatable tbody").append(
                                "<tr>" +

                                "<td>" + fullname + "</td>" +
                                "<td>" + HouseNumber + "</td>" +
                                "<td>" + NeighborhoodName + "</td>" +
                                "<td>" + SubNeighborhoodName + "</td>" +
                                "<td>" + number + "</td>" +
                             
                                                               "<td>" +
                                '<button class="btn btn-success me-3 edit-button" data-id="' + PaymentStatusID + '" type="button">' +
                                'Pay Now' +
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














        $("#datatable").on("click", ".edit-button", function (event) {
            event.preventDefault(); // Prevent default behavior

            var row = $(this).closest("tr");
            var id = $(this).data("id");

         
            var name = row.find("td:nth-child(1)").text();

            $("#id1").val(id);
      
            $.ajax({
                type: "POST",
                url: "pay.aspx/money",
                data: "{'id':'" + id + "'} ",
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
                    $("#displayAmountRequired").text('$' + TotalAmount.toFixed(2));
                    $("#displayRemainingAmount").text('$' + TotalDueAmount.toFixed(2));
                    $("#displayCreditAmount").text('$' + TotalDifference.toFixed(2));
                },
                error: function (xhr, status, error) {
                    console.error(xhr.responseText);
                }
            });

     

            $('#stockmodal').modal('show');


        });






        function submitlacag() {
            const amountRequired = document.getElementById('amountRequired').value;
            const creditAmount = document.getElementById('creditAmount').value;
            const remainingAmount = document.getElementById('remainingAmount').value;
            const id = document.getElementById('id1').value;
        
            var PaymentPeriodID = $('#PaymentPeriodID').text();
            alert(PaymentPeriodID);
            let isValid = true;

            if (!amountRequired) {
                document.getElementById('amountRequiredError').textContent = "Please enter the amount required.";
                isValid = false;
            } else {
                document.getElementById('amountRequiredError').textContent = "";
            }

            if (!creditAmount) {
                document.getElementById('creditAmountError').textContent = "Please enter the credit amount.";
                isValid = false;
            } else {
                document.getElementById('creditAmountError').textContent = "";
            }
            
            if (isValid) {
                $.ajax({
                    url: 'pay.aspx/addlacag',
                    data: "{'id':'" + id + "','amountRequired':'" + amountRequired + "','creditAmount':'" + creditAmount + "','remainingAmount':'" + remainingAmount + "','PaymentPeriodID':'" + PaymentPeriodID + "'  }",
                    dataType: "json",
                    type: 'POST',
                    contentType: "application/json",
                    success: function (response) {
                        console.log(response);
                        $('#stockmodal').modal('hide');
                        Swal.fire(
                            'Successfully Updated!',
                            'You updated the details successfully!',
                            'success'
                        );

                        clearInputFields();
                        datadisplay();
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }
        }

        function clearInputFields() {
            document.getElementById('amountRequired').value = "";
            document.getElementById('creditAmount').value = "";
            document.getElementById('remainingAmount').value = "";
            document.getElementById('amountRequiredError').textContent = "";
            document.getElementById('creditAmountError').textContent = "";

            // Clear the displayed data
            document.getElementById('displayAmountRequired').textContent = "";
            document.getElementById('displayCreditAmount').textContent = "";
            document.getElementById('displayRemainingAmount').textContent = "";
        }


        function openRepayInput() {
            document.getElementById('repaySection').style.display = 'block';
        }

        function submitRepay() {
            const repayAmount = document.getElementById('repayAmount').value;
            const id = document.getElementById('id1').value;

            let isValid = true;

            if (!repayAmount) {
                document.getElementById('repayAmountError').textContent = "Please enter the amount to repay.";
                isValid = false;
            } else {
                document.getElementById('repayAmountError').textContent = "";
            }

            if (isValid) {

                $.ajax({
                    url: 'pay.aspx/paydeyn',
                    data: "{'id':'" + id + "','repayAmount':'" + repayAmount + "' }",
                    dataType: "json",
                    type: 'POST',
                    contentType: "application/json",
                    success: function (response) {
                        console.log(response);
                        $('#stockmodal').modal('hide');
                        Swal.fire(
                            'Repayment Successful!',
                            'You have successfully repaid the credit amount of ' + repayAmount,
                            'success'
                        );

                        clearInputFields();
                        datadisplay();
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
                // Here you can add AJAX to handle repayment logic if needed
              

                document.getElementById('repayAmount').value = "";
                document.getElementById('repaySection').style.display = 'none';
            }
        }

    </script>

</asp:Content>
