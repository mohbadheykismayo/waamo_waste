<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thepayments.aspx.cs" Inherits="waamowaste.thepayments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payments Section</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" href="assets/css/custom.css" />
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="page-header">
                <h1>Payments Section</h1>
            </div>
            <div class="action-buttons">
                <div>
                    <button type="button" class="btn btn-primary"><i class="fas fa-plus"></i> Add Payment</button>
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
    </form>
    <script src="assets/js/jquery-3.6.0.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/jquery.dataTables.min.js"></script>
    <script src="assets/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script>
        datadisplay();
        function datadisplay() {
            $.ajax({
                url: 'houses.aspx/datadisplay',
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
                        var IsActive = response.d[i].IsActive;
                        var fullname = response.d[i].fullname;
                        var number = response.d[i].number;
                        var HouseID = response.d[i].HouseID;

                        $("#datatable tbody").append(
                            "<tr>" +
                            "<td>" + fullname + "</td>" +
                            "<td>" + HouseNumber + "</td>" +
                            "<td>" + NeighborhoodName + "</td>" +
                            "<td>" + SubNeighborhoodName + "</td>" +
                            "<td>" + number + "</td>" +
                            "<td>" + IsActive + "</td>" +
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
        }
    </script>
</body>
</html>
