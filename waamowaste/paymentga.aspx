<%@ Page Title="" Language="C#" MasterPageFile="~/home.Master" AutoEventWireup="true" CodeBehind="paymentga.aspx.cs" Inherits="waamowaste.paymentga" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" href="assets/css/custom.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link href="assets/plugins/select2/css/select2.min.css" rel="stylesheet" />
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .page-header {
            padding: 20px;
            text-align: center;
            background-color: #007bff;
            color: white;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .action-buttons .btn {
            margin-right: 10px;
        }
        .table-responsive {
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            overflow: hidden;
        }
        .table thead th {
            background-color: #343a40;
            color: white;
            text-align: center;
        }
        .table tbody td {
            text-align: center;
            vertical-align: middle;
        }
        .edit-button img, .delete-btn img {
            cursor: pointer;
            transition: transform 0.3s;
        }
        .edit-button img:hover, .delete-btn img:hover {
            transform: scale(1.1);
        }
        .dataTables_wrapper .dataTables_filter input {
            border-radius: 20px;
            padding: 5px 15px;
            border: 1px solid #007bff;
        }
        .dataTables_wrapper .dataTables_length select {
            border-radius: 20px;
            padding: 5px;
            border: 1px solid #007bff;
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button {
            border-radius: 50%;
            border: none;
            padding: 8px;
            background-color: #007bff;
            color: white;
            margin: 2px;
            transition: background-color 0.3s;
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
            background-color: #0056b3;
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button.current {
            background-color: #343a40;
            color: white;
        }
        /* Style the Select2 container to be more prominent */
.select2-container--bootstrap-5 .select2-selection--single {
    height: 38px; /* Matches typical form-control height */
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
}

.select2-container--bootstrap-5 .select2-selection__rendered {
    line-height: 36px; /* Centers text vertically */
    color: #495057;
}

.select2-container--bootstrap-5 .select2-selection__arrow {
    height: 38px;
    top: 0;
    right: 10px;
}

/* Optional: Increase search input padding for better appearance */
.select2-search--dropdown .select2-search__field {
    padding: 8px;
    border: 1px solid #ced4da;
}

    </style>




    <style>
        /* Modal Container */
#modalContent {
    background: linear-gradient(135deg, #00c6ff, #0072ff);
    border-radius: 10px;
    color: white;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    overflow: hidden;
}

/* Modal Header */
#modalHeader {
    background: linear-gradient(to right, #005bea, #00c6ff);
    color: white;
    font-size: 1.5rem;
    text-transform: uppercase;
    padding: 20px;
    border-bottom: none;
}

#modalHeader h5 {
    font-weight: bold;
    letter-spacing: 2px;
}

/* Modal Body */
#modalBody {
    padding: 30px;
    background: #f4f4f9;
    color: #333;
}

/* Styled Table */
#styledTable {
    background-color: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

#styledTable thead {
    background-color: #0072ff;
    color: white;
    text-transform: uppercase;
}

#styledTable th, #styledTable td {
    padding: 15px;
    border-bottom: 1px solid #ddd;
}

#styledTable tbody tr:hover {
    background-color: rgba(0, 114, 255, 0.1);
    cursor: pointer;
}

/* Form Styling */
#paymentForm {
    margin-top: 20px;
}

#amountInput {
    padding: 15px;
    font-size: 1.2rem;
    border: 2px solid #0072ff;
    border-radius: 6px;
}

/* Submit Button */
#submitPayment {
    background-color: #28a745;
    color: white;
    font-size: 1.2rem;
    padding: 15px;
    margin-top: 20px;
    border: none;
    border-radius: 6px;
    transition: background-color 0.3s ease;
}

#submitPayment:hover {
    background-color: #218838;
}

/* Modal Footer */
#modalFooter {
    background: #f4f4f9;
    border-top: none;
    padding: 20px;
}

/* Cancel Button */
#modalFooter .btn-secondary {
    background-color: #dc3545;
    border-color: #dc3545;
    color: white;
    padding: 10px 20px;
    font-size: 1.1rem;
}

#modalFooter .btn-secondary:hover {
    background-color: #c82333;
    border-color: #bd2130;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="page-header">
            <h1>Payments Section</h1>
        </div>
        <div class="action-buttons">
            <div>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPaymentModal"><i class="fas fa-plus"></i> Add Payment</button>
                <button type="button" class="btn btn-success"><i class="fas fa-sync-alt"></i> Refresh Data</button>
            </div>
            <div>
                <button type="button" class="btn btn-danger"><i class="fas fa-trash-alt"></i> Delete All</button>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-striped table-hover" id="datatable">
                <thead>
                    <tr>
                        <th>Fullname</th>
                        <th>House Number</th>
                        <th>Neighborhood</th>
                        <th>Sub-Neighborhood</th>
                        <th>Phone Number</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

   <!-- Add Payment Modal -->
<div class="modal fade" id="addPaymentModal" tabindex="-1" role="dialog" aria-labelledby="addPaymentModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addPaymentModalLabel">Charge</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
         
                    <div class="form-group">
                        <label for="chargeType">Select Charge Type</label>
                        <select class="form-control" id="chargeType">
                            <option value="">Select charge type</option>
                            <option value="single">Single Charge</option>
                            <option value="all">All Charge</option>
                        </select>
                    </div>
                    <!-- Single Charge: House select -->
                    <div class="form-group" id="houseSelectContainer" style="display:none;">
                        <label for="selectHouse">Select House</label>
                        <select class="form-control   select2-enhanced" id="selectHouse">
                            <option value="">Select a house</option>
                            <!-- Dynamic house options will be populated here -->
                        </select>
                    </div>
                    <!-- Date input (for both charge types) -->
                    <div class="form-group" id="paymentDateContainer" style="display:none;">
                        <label for="paymentDate">Payment Date</label>
                        <input type="date" class="form-control" id="paymentDate" />
                    </div>
               <%--     <div class="form-group" id="amountContainer" style="display:none;">
                        <label for="paymentAmount">Amount</label>
                        <input type="number" class="form-control" id="paymentAmount" placeholder="Enter amount" />
                    </div>
                    <div class="form-group" id="statusContainer" style="display:none;">
                        <label for="paymentStatus">Status</label>
                        <select class="form-control" id="paymentStatus">
                            <option value="paid">Paid</option>
                            <option value="unpaid">Unpaid</option>
                        </select>
                    </div>--%>
            
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="savePaymentButton">Save Payment</button>
            </div>
        </div>
    </div>
</div>


<!-- Eye-Catching Custom Styled Payment Modal -->
<div class="modal fade" id="customEyeCatchingModal" tabindex="-1" aria-labelledby="customEyeCatchingModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content" id="modalContent">
      <!-- Modal Header -->
      <div class="modal-header" id="modalHeader">
        <h5 class="modal-title" id="customEyeCatchingModalLabel">Payment Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <!-- Modal Body with table and form -->
      <div class="modal-body" id="modalBody">
        <div class="table-responsive">
          <table class="table" id="styledTable">
            <thead>
              <tr>
                <th>Full Name</th>
                <th>House Number</th>
                <th>Neighborhood</th>
                <th>Sub-Neighborhood</th>
                <th>Contact Number</th>
                <th>Due Amount</th>
              </tr>
            </thead>
            <tbody id="modalTableBody">
              <!-- Dynamic content goes here -->
            </tbody>
          </table>
        </div>
        <!-- Payment form -->
        <form id="paymentForm">
          <div class="mb-3">
            <label for="amountInput" class="form-label">Enter Payment Amount</label>
            <input type="number" class="form-control" id="amountInput" placeholder="Enter amount">
          </div>
          <button type="button" class="btn btn-primary w-100" id="submitPayment">Submit Payment</button>
        </form>
      </div>
      <!-- Modal Footer -->
      <div class="modal-footer" id="modalFooter">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>

    <script src="assets/js/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.dataTables.min.js"></script>
    <script src="assets/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="assets/plugins/select2/js/select2.min.js"></script>

    <script>

        $(document).ready(function () {
            $('#savePaymentButton').click(function () {
                var chargeType = $('#chargeType').val();  // Get charge type (single or all)
                var houseID = $('#selectHouse').val();    // House ID for single charge
                //var paymentMonth = $('#paymentMonth').val();  // Month for the payment
                //var paymentYear = $('#paymentYear').val();    // Year for the payment
                var paymentDate = $('#paymentDate').val();
                //var paymentAmount = $('#paymentAmount').val();  // Payment amount
                //var paymentStatus = $('#paymentStatus').val();  // Payment status (paid/unpaid)

                // Perform basic validation
                if (chargeType === 'single' && !houseID) {
                    Swal.fire('Error', 'Please select a house for Single Charge', 'error');
                    return;
                }
                // Check if payment date is provided
                if (!paymentDate) {
                    Swal.fire('Error', 'Please select a payment date', 'error');
                    return;
                }

                // Extract the month and year from the paymentDate
                var paymentMonth = new Date(paymentDate).getMonth() + 1;  // Months are 0-based in JavaScript, so +1
                var paymentYear = new Date(paymentDate).getFullYear();


                // AJAX call to insert the payment
                $.ajax({
                    type: "POST",
                    url: "paymentga.aspx/InsertPayment",  // WebForm URL
                    data: JSON.stringify({
                        chargeType: chargeType,
                        houseID: houseID,
                        paymentMonth: paymentMonth,
                        paymentYear: paymentYear,
                        //paymentAmount: paymentAmount,
                        //paymentStatus: paymentStatus
                    }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        // Check if the server returned 'success'
                        if (response.d === 'success') {
                            Swal.fire('Success', 'Payment added successfully!', 'success').then(function () {
                                $('#addPaymentModal').modal('hide');  // Hide the modal
                                location.reload();  // Optionally reload the page
                            });
                        } else {
                            // Display the error message from the server in a SweetAlert dialog
                            Swal.fire('Error', response.d, 'error');
                        }
                    },
                    error: function (xhr, status, error) {
                        // Display a general error message in case the AJAX call itself fails
                        Swal.fire('Error', 'An error occurred: ' + error, 'error');
                    }
                });
            });
        });

        $(document).ready(function () {
            // Load house data with AJAX and initialize Select2 with enhanced styles
            $.ajax({
                type: "POST",
                url: "paymentga.aspx/getdate",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    var getdate = $("#selectHouse");
                    getdate.empty().append('<option selected="selected" value="0">Please select</option>');

                    // Populate select with options
                    $.each(r.d, function () {
                        getdate.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });

                    // Initialize Select2 with a theme and custom placeholder
                    getdate.select2({
                        placeholder: "Search for a house",
                        allowClear: true,
                        theme: "bootstrap-5", // Use Bootstrap theme if available
                        width: '100%'  // Makes sure the select fits inside the form
                    });
                },
                error: function () {
                    console.error('Error fetching house data.');
                }
            });
        });

        document.getElementById('chargeType').addEventListener('change', function () {
            const chargeType = this.value;
            const houseSelectContainer = document.getElementById('houseSelectContainer');
            const paymentDateContainer = document.getElementById('paymentDateContainer');
            //const amountContainer = document.getElementById('amountContainer');
            //const statusContainer = document.getElementById('statusContainer');

            if (chargeType === 'single') {
                houseSelectContainer.style.display = 'block'; // Show house select
                paymentDateContainer.style.display = 'block'; // Show date input
                //amountContainer.style.display = 'block'; // Show amount input
                //statusContainer.style.display = 'block'; // Show status input
            } else if (chargeType === 'all') {
                houseSelectContainer.style.display = 'none'; // Hide house select
                paymentDateContainer.style.display = 'block'; // Show only date input
                //amountContainer.style.display = 'none'; // Hide amount input
                //statusContainer.style.display = 'none'; // Hide status input
            } else {
                // If no charge type is selected, hide all fields
                houseSelectContainer.style.display = 'none';
                paymentDateContainer.style.display = 'none';
                //amountContainer.style.display = 'none';
                //statusContainer.style.display = 'none';
            }
        });

        //$(document).ready(function () {
        //    $('#datatable').DataTable({
        //        "paging": true,
        //        "searching": true,
        //        "info": true,
        //        "responsive": true,
        //        "autoWidth": false,
        //        "order": [[0, "asc"]],
        //        "language": {
        //            "search": "<i class='fas fa-search'></i> Search:",
        //            "lengthMenu": "_MENU_ entries per page",
        //            "paginate": {
        //                "previous": "<i class='fas fa-chevron-left'></i>",
        //                "next": "<i class='fas fa-chevron-right'></i>"
        //            }
        //        }
        //    });
        //});

        datadisplay();
        function datadisplay() {
            $.ajax({
                url: 'paymentga.aspx/datadisplay',
                dataType: "json",
                type: 'POST',
                contentType: "application/json",
                success: function (response) {
                    console.log(response)
                    var datatable = $('#datatable').DataTable();
                    datatable.clear();
                    for (var i = 0; i < response.d.length; i++) {
                        var NeighborhoodName = response.d[i].NeighborhoodName;
                        var SubNeighborhoodName = response.d[i].SubNeighborhoodName;
                        var HouseNumber = response.d[i].HouseNumber;
                        var IsActive = response.d[i].IsActive;
                        var fullname = response.d[i].fullname;
                        var number = response.d[i].number;
                        var HouseID = response.d[i].HouseID;


                        var amount = response.d[i].amount;
                        var DueAmount = response.d[i].DueAmount;
                        var PaymentStatusID = response.d[i].PaymentStatusID;


















                        datatable.row.add([
                            fullname,
                            HouseNumber,
                            NeighborhoodName,
                            SubNeighborhoodName,
                            number,
                            DueAmount,
                            '<a class="me-3 edit-button" data-id="' + HouseID + '">' +
                            '<img src="assets/img/icons/edit.svg" alt="Edit">' +
                            '</a>' +
                            '<a class="me-3 delete-btn" data-id="' + HouseID + '">' +
                            '<img src="assets/img/icons/delete.svg" alt="Delete">' +
                            '</a>'
                        ]).draw();
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

            //$("#id").val(id);
            //$("#catname").val(name);

            alert(id);
            $.ajax({
                url: 'paymentga.aspx/datadisplay1',
                data: "{'id':'" + id + "' }",
                dataType: "json",
                type: 'POST',
                contentType: "application/json",
                success: function (response) {
                    console.log(response)


                    $("#styledTable tbody").empty();

                    for (var i = 0; i < response.d.length; i++) {
                        var NeighborhoodName = response.d[i].NeighborhoodName;
                        var SubNeighborhoodName = response.d[i].SubNeighborhoodName;
                        var HouseNumber = response.d[i].HouseNumber;
                        var IsActive = response.d[i].IsActive;
                        var fullname = response.d[i].fullname;
                        var number = response.d[i].number;
                        var HouseID = response.d[i].HouseID;


                        var amount = response.d[i].amount;
                        var DueAmount = response.d[i].DueAmount;
                        var PaymentStatusID = response.d[i].PaymentStatusID;













                        $("#styledTable tbody").append(
                            "<tr>" +
                            "<td>" + fullname + "</td>" +
                            "<td>" + HouseNumber + "</td>" +
                            "<td>" + NeighborhoodName + "</td>" +
                            "<td>" + SubNeighborhoodName + "</td>" +
                            "<td>" + number + "</td>" +
                            "<td>" + DueAmount + "</td>" +
                             "<td>" +
                            '<a class="me-3 edit-button" data-id="' + HouseID + '">' +
                            '<img src="assets/img/icons/edit.svg" alt="Edit">' +
                            '</a>' +
                            '<a class="me-3 delete-btn" data-id="' + HouseID + '">' +
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

   





            $('#customEyeCatchingModal').modal('show');


        });
    </script>
</asp:Content>
