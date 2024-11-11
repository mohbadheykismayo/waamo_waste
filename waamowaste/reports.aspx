<%@ Page Title="" Language="C#" MasterPageFile="~/home.Master" AutoEventWireup="true" CodeBehind="reports.aspx.cs" Inherits="waamowaste.reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .report-container {
            margin-top: 40px;
        }
        .collapse-btn {
            background-color: #0062cc;
            color: white;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .btn-group .btn {
            margin-right: 5px;
        }
        .accordion-item {
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .accordion-button {
            font-size: 1.1rem;
            padding: 15px;
        }
        .accordion-body {
            background-color: #e9ecef;
            border-top: 1px solid #dee2e6;
            padding: 20px;
        }
        @media (max-width: 768px) {
            .accordion-button {
                font-size: 1rem;
            }
            .btn-group .btn {
                margin-bottom: 5px;
            }
        }
        @media print {
    /* General body styles for printing */
    body {
        font-family: 'Arial', sans-serif;
        color: #2c3e50;
        margin: 20px;
    }

    /* Report Title with Color */
    h5 {
        text-align: center;
        color: #34495e !important; /* Ensure color is forced in print */
        font-size: 1.8rem;
        margin-bottom: 20px;
    }

    /* Report Date with Color */
    p {
        text-align: center;
        color: #2c3e50 !important; /* Ensure color is forced in print */
        margin-bottom: 15px;
        font-weight: bold;
    }

    /* Table styles with forced colors */
    #reportTable {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
        page-break-inside: avoid;
    }

    #reportTable th,
    #reportTable td {
        border: 1px solid #2c3e50;
        padding: 12px;
        text-align: center;
        page-break-inside: avoid;
        font-size: 1rem;
    }

    #reportTable th {
        background-color: #2c3e50 !important; /* Force background color for print */
        color: #ffffff !important; /* Force text color for print */
        font-size: 1.1rem;
        -webkit-print-color-adjust: exact; /* Ensure colors are printed correctly */
        print-color-adjust: exact; /* Ensure colors are printed correctly */
    }

    #reportTable tbody {
        background-color: #f8f9fa !important; /* Force background color for print */
    }

    #reportTable tfoot {
        background-color: #2c3e50 !important; /* Force background color for print */
        color: #ecf0f1 !important; /* Force text color for print */
        font-weight: bold;
        page-break-inside: avoid;
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
    }

    /* Hide unnecessary elements when printing */
    .btn,
    .modal-footer,
    .modal-header,
    .btn-close {
        display: none !important;
    }

    /* Prevent cutting off table rows */
    table,
    tr,
    th,
    td {
        page-break-inside: avoid;
    }

    /* Ensure modal dimensions are suitable for print */
    .modal-content {
        margin: 0 auto;
        max-width: 100%;
        width: auto;
    }
}

    </style>


  

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container report-container">
        <div class="row">
            <div class="col-12 text-center mb-5">
                <h2 class="display-6">Waste Collection Company Reports</h2>
                <p class="lead">Select a report below to view more details</p>
            </div>
        </div>
        <div class="accordion" id="reportAccordion">
            <!-- Example Report Items -->
        <div class="accordion-item">
        <h2 class="accordion-header" id="heading1">
            <button class="accordion-button collapse-btn" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1">
                Monthly Payment Report
            </button>
        </h2>
        <div id="collapse1" class="accordion-collapse collapse" aria-labelledby="heading1" data-bs-parent="#reportAccordion">
            <div class="accordion-body">
                <p>Description: Financial overview for January 2024, including revenue, expenses, and profit analysis.</p>
                
                    
                <!-- Add DateTime Picker -->
                <div class="mb-3">
                    <label for="reportDate" class="form-label">Select Date:</label>
                    <input type="date" class="form-control" id="reportDate" placeholder="Choose a date">
                </div>

                <!-- Buttons for Paid and Not Paid -->
                <div class="btn-group" role="group" aria-label="Payment Status">
                    <button type="button" class="btn btn-success" onclick="fetchData('paid')">Paid</button>
                    <button type="button" class="btn btn-danger" onclick="fetchData1('notpaid')">Not Paid</button>
                </div>
                </div>
                
               
            </div>
        </div>
    </div>
            <div class="accordion-item">
                <h2 class="accordion-header" id="heading2">
                    <button class="accordion-button collapse-btn" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2">
                        Report: Waste Collection Route Efficiency - February 2024
                    </button>
                </h2>
                <div id="collapse2" class="accordion-collapse collapse" aria-labelledby="heading2" data-bs-parent="#reportAccordion">
                    <div class="accordion-body">
                        <p>Description: Analysis of waste collection route efficiency for February 2024, including time and cost savings.</p>
                        <div class="btn-group flex-wrap" role="group">
                            <button type="button" class="btn btn-primary">View Summary</button>
                            <button type="button" class="btn btn-secondary">Download Report</button>
                            <button type="button" class="btn btn-success">View Detailed Report</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header" id="heading3">
                    <button class="accordion-button collapse-btn" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3">
                        Report: GPS Mapping Overview - March 2024
                    </button>
                </h2>
                <div id="collapse3" class="accordion-collapse collapse" aria-labelledby="heading3" data-bs-parent="#reportAccordion">
                    <div class="accordion-body">
                        <p>Description: Overview of GPS mapping for waste collection routes, highlighting coverage and potential areas for optimization.</p>
                        <div class="btn-group flex-wrap" role="group">
                            <button type="button" class="btn btn-primary">View Summary</button>
                            <button type="button" class="btn btn-secondary">Download Report</button>
                            <button type="button" class="btn btn-success">View Detailed Report</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Add more report items as needed -->
        </div>

<!-- Modal -->
<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #34495e; color: #ecf0f1;">
                <h5 class="modal-title" id="reportModalLabel">Sub-Neighborhood Payment Report</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Report Date -->
                <div class="d-flex justify-content-between align-items-center mb-3" style="border-bottom: 2px solid #2c3e50; padding-bottom: 10px;">
                    <h6 style="color: #2c3e50;">Report Date: <span id="reportDateDisplay"></span></h6>
                </div>
                
                <!-- Table -->
                <div class="table-responsive">
                    <table id="reportTable" class="table table-striped table-bordered text-center" style="border-color: #2c3e50;">
                        <thead style="background-color: #2c3e50; color: #ecf0f1;">
                            <tr>
                                <th style="background-color: #2c3e50; color: #ffffff;">Sub-Neighborhood</th>
                                <th style="background-color: #2c3e50; color: #ffffff;">Total Paid Amount</th>
                            </tr>
                        </thead>
                        <tbody id="reportTableBody" style="background-color: #f8f9fa;">
                            <!-- Dynamic rows will be inserted here -->
                        </tbody>
                        <tfoot>
                            <tr style="background-color: #2c3e50; color: #ecf0f1; font-weight: bold;">
                                <td colspan="2" id="totalPaidAmount">Total Paid Amount: --</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
            <div class="modal-footer" style="background-color: #34495e;">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="printReport()">Print Report</button>
            </div>
        </div>
    </div>
</div>

<!-- Trigger button -->
<button type="button" id="showReportBtn" class="btn btn-primary" style="display:none;" data-bs-toggle="modal" data-bs-target="#reportModal">
    View Report
</button>





    <!-- Bootstrap JavaScript and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
       <script src="assets/js/jquery-3.6.0.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>
   <script src="assets/js/jquery.dataTables.min.js"></script>
   <script src="assets/js/dataTables.bootstrap4.min.js"></script>
   <script src="https://kit.fontawesome.com/a076d05399.js"></script>
   <script src="assets/plugins/select2/js/select2.min.js"></script>


    <script>
        function fetchData() {
            var selectedDate = document.getElementById("reportDate").value;
       
            if (selectedDate === "") {
                alert("Please select a date");
                return;
            }

            $.ajax({
                type: "POST",
                url: "reports.aspx/GetReportData",
                data: JSON.stringify({ selectedDate: selectedDate }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response); // Inspect the server response structure
                    var data = JSON.parse(response.d);

                    // Check if there's data for SubNeighborhoods
                    if (data.SubNeighborhoods.length > 0) {
                        // Clear the existing table content
                        var tableBody = document.getElementById('reportTableBody');
                        tableBody.innerHTML = '';

                        // Loop through SubNeighborhoods and append rows
                        data.SubNeighborhoods.forEach(function (subNeighborhood) {
                            var totalPaid = subNeighborhood.TotalPaidPerSubNeighborhood;
                            totalPaid = (totalPaid != null && !isNaN(totalPaid))
                                ? totalPaid.toLocaleString('en-US', { style: 'currency', currency: 'USD' })
                                : "N/A";

                            var row = `
                <tr>
                    <td>${subNeighborhood.SubNeighborhoodName || "N/A"}</td>
                    <td>${totalPaid}</td>
                </tr>`;
                            tableBody.insertAdjacentHTML('beforeend', row);
                        });

                        // Check and display the total paid amount for the month/year
                        if (data.TotalPaidForMonthYear.length > 0 && data.TotalPaidForMonthYear[0].TotalPaidForMonthYear != null) {
                            var totalPaid = data.TotalPaidForMonthYear[0].TotalPaidForMonthYear;
                            totalPaid = totalPaid.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
                            document.getElementById('totalPaidAmount').innerText = `Total Paid: ${totalPaid}`;
                        } else {
                            document.getElementById('totalPaidAmount').innerText = "No Total Paid data available.";
                        }

                        // Trigger the modal to show the report
                        document.getElementById('showReportBtn').click();
                    } else {
                        alert("No data available for the selected date.");
                    }
                },



                error: function (xhr, status, error) {
                    console.log("Error: " + error);
                }
            });
        }

        document.addEventListener('DOMContentLoaded', () => {
            // Display the current date in the modal
            var today = new Date();
            var formattedDate = today.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
            document.getElementById('reportDateDisplay').innerText = formattedDate;
        });

       
            function printReport() {
        // Get the report table and report date
        var printContents = document.getElementById('reportTable').outerHTML;
            var reportDate = document.getElementById('reportDateDisplay').innerText;

            // Create a new window for print preview
            var newWindow = window.open('', '', 'height=600,width=800');

            // Write HTML content for the new window
            newWindow.document.write('<html><head><title>Print Report</title>');
                newWindow.document.write('<style>');
                    newWindow.document.write(`
                    body {
                        font - family: Arial, sans-serif;
                    color: #2c3e50;
                    margin: 20px;
            }
                    h5 {
                        text - align: center;
                    color: #34495e;
                    font-size: 1.8rem;
                    margin-bottom: 20px;
            }
                    p {
                        text - align: center;
                    color: #2c3e50;
                    margin-bottom: 15px;
                    font-weight: bold;
            }
                    #reportTable {
                        width: 100%;
                    border-collapse: collapse;
                    margin-bottom: 20px;
                    page-break-inside: avoid;
            }
                    #reportTable th, #reportTable td {
                        border: 1px solid #2c3e50;
                    padding: 12px;
                    text-align: center;
                    page-break-inside: avoid;
                    font-size: 1rem;
            }
                    #reportTable th {
                        background - color: #2c3e50;
                    color: #ecf0f1;
                    font-size: 1.1rem;
            }
                    #reportTable tbody {
                        background - color: #f8f9fa;
            }
                    #reportTable tfoot {
                        background - color: #2c3e50;
                    color: #ecf0f1;
                    font-weight: bold;
                    page-break-inside: avoid;
            }
                    /* Hide buttons and modal headers during print */
                    .btn, .modal-footer, .modal-header, .btn-close {
                        display: none !important;
            }
                    table, tr, th, td {
                        page -break-inside: avoid;
            }
                    `);
                    newWindow.document.write('</style></head><body>');
                        newWindow.document.write(`<h5>Sub-Neighborhood Payment Report</h5>`);
                    newWindow.document.write(`<p>Report Date: ${reportDate}</p>`);
        newWindow.document.write(printContents);
        newWindow.document.write('</body></html>');

        // Close the document before printing
        newWindow.document.close();

        // Focus on the new window before printing
        newWindow.focus();

        // Trigger print preview
        newWindow.print();
    }








        function fetchData1() {
            var selectedDate = document.getElementById("reportDate").value;

            if (selectedDate === "") {
                alert("Please select a date");
                return;
            }

            $.ajax({
                type: "POST",
                url: "reports.aspx/GetReportData1",
                data: JSON.stringify({ selectedDate: selectedDate }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response); // Inspect the server response structure
                    var data = JSON.parse(response.d);
                    console.log(data);
                    // Check if there's data for SubNeighborhoods
                    if (data.SubNeighborhoods.length > 0) {
                        // Clear the existing table content
                        var tableBody = document.getElementById('reportTableBody');
                        tableBody.innerHTML = '';

                        // Loop through SubNeighborhoods and append rows
                        data.SubNeighborhoods.forEach(function (subNeighborhood) {
                            var Amount = subNeighborhood.Amount;
                            totalAmountPaid = (Amount != null && !isNaN(Amount))
                                ? Amount.toLocaleString('en-US', { style: 'currency', currency: 'USD' })
                                : "N/A";

                            var row = `
             <tr>
                 <td>${subNeighborhood.SubNeighborhoodName || "N/A"}</td>
                 <td>${Amount}</td>
             </tr>`;
                            tableBody.insertAdjacentHTML('beforeend', row);
                        });

                        // Check and display the total paid amount for the month/year
                        if (data.TotalUnpaidForMonthYear.length > 0 && data.TotalUnpaidForMonthYear[0].TotalUnpaidForMonthYear != null) {
                            var totalPaid = data.TotalUnpaidForMonthYear[0].TotalUnpaidForMonthYear;
                            totalPaid = totalPaid.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
                            document.getElementById('totalPaidAmount').innerText = `Total Paid: ${totalPaid}`;
                        } else {
                            document.getElementById('totalPaidAmount').innerText = "No Total Paid data available.";
                        }

                        // Trigger the modal to show the report
                        document.getElementById('showReportBtn').click();
                    } else {
                        alert("No data available for the selected date.");
                    }
                },



                error: function (xhr, status, error) {
                    console.log("Error: " + error);
                }
            });
        }
    </script>
</asp:Content>
