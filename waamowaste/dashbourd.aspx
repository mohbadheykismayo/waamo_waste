<%@ Page Title="" Language="C#" MasterPageFile="~/home.Master" AutoEventWireup="true" CodeBehind="dashbourd.aspx.cs" Inherits="waamowaste.dashbourd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" href="assets/css/custom.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link href="assets/plugins/select2/css/select2.min.css" rel="stylesheet" />


    <style>
    #paymentChart {
        background: linear-gradient(to right, #f0f2f5, #ffffff);
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        border-radius: 12px;
        padding: 20px;
    }
</style>
<style>
    body {
        background: #f3f4f6;
        font-family: 'Roboto', sans-serif;
        color: #333;
    }

    .card {
        border-radius: 12px;
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0px 10px 15px rgba(0, 0, 0, 0.2);
    }

    .card-header {
        border-bottom: none;
        border-radius: 12px 12px 0 0;
    }

    #mapSearchInput {
        border-radius: 8px 0 0 8px;
    }

    #searchMapBtn {
        border-radius: 0 8px 8px 0;
    }

    #mapContainer {
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
    }
</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



<div class="container-fluid">
    <!-- Row 1: Payment Chart -->
    <div class="row ">
        <div class="col-lg-8 col-md-12">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-primary text-white text-center">
                    <h5 class="mb-0">Payments Overview</h5>
                </div>
                <div class="card-body">
                    <canvas id="paymentChart" style="max-height: 100%; width: 100%;"></canvas>
                </div>
            </div>
        </div>

        <!-- Statistics -->
        <div class="col-lg-4 col-md-12">
            <div class="row g-4">
                <!-- Total Houses -->
                <div class="col-6">
                    <div class="card shadow-sm border-0 text-center">
                        <div class="card-body">
                            <h4 class="text-primary fw-bold">Total Houses</h4>
                            <span class="display-4 text-dark" id="houses">0</span>
                        </div>
                    </div>
                </div>
                <!-- Total Employees -->
                <div class="col-6">
                    <div class="card shadow-sm border-0 text-center">
                        <div class="card-body">
                            <h4 class="text-success fw-bold">Total Employees</h4>
                            <span class="display-4 text-dark" id="employees">0</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Row 2: Map Search Section -->
    <div class="row g-4 mt-4">
        <div class="col-12">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-dark text-white text-center">
                    <h5 class="mb-0">Search Locations</h5>
                </div>
                <div class="card-body">
                    <div class="input-group">
                        <input type="text" class="form-control" id="mapSearchInput" placeholder="Search for locations or addresses..." />
                        <button class="btn btn-primary" id="searchMapBtn">Search</button>
                    </div>
                    <div id="mapContainer" class="mt-4" style="height: 350px; width: 100%; background: #e9ecef; border-radius: 8px;">
                        <!-- Map will be rendered here -->
                        <p class="text-center mt-5 text-muted">Map loading...</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

        <script src="assets/js/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.dataTables.min.js"></script>
    <script src="assets/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="assets/plugins/select2/js/select2.min.js"></script>







<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Fetch data from the server
        fetch('dashbourd.aspx/GetPaymentData', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
        })
            .then(response => response.json())
            .then(data => {
                const chartData = data.d.map(item => ({
                    label: item.MonthYear,
                    value: item.TotalAmountPerMonth
                }));

                const labels = chartData.map(item => item.label);
                const values = chartData.map(item => item.value);

                // Create gradient background
                const ctx = document.getElementById('paymentChart').getContext('2d');
                const gradient = ctx.createLinearGradient(0, 0, 0, 400);
                gradient.addColorStop(0, 'rgba(75, 192, 192, 0.8)');
                gradient.addColorStop(1, 'rgba(75, 192, 192, 0.2)');

                // Initialize the chart
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Total Payments',
                            data: values,
                            backgroundColor: gradient,
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 2,
                            borderRadius: 10,
                            hoverBackgroundColor: 'rgba(54, 162, 235, 0.8)',
                            hoverBorderColor: 'rgba(54, 162, 235, 1)'
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                display: true,
                                labels: {
                                    font: {
                                        size: 14,
                                        family: 'Arial, sans-serif',
                                    },
                                    color: '#333',
                                }
                            },
                            datalabels: {
                                anchor: 'end',
                                align: 'top',
                                formatter: (value) => `$${value.toLocaleString()}`,
                                font: {
                                    size: 12,
                                    weight: 'bold',
                                    family: 'Arial, sans-serif',
                                },
                                color: '#333',
                            }
                        },
                        scales: {
                            x: {
                                grid: {
                                    display: false,
                                },
                                ticks: {
                                    font: {
                                        size: 12,
                                    },
                                    color: '#555',
                                }
                            },
                            y: {
                                grid: {
                                    color: 'rgba(200, 200, 200, 0.3)',
                                    drawBorder: false,
                                },
                                ticks: {
                                    font: {
                                        size: 12,
                                    },
                                    color: '#555',
                                    callback: (value) => `$${value.toLocaleString()}`,
                                }
                            }
                        },
                        layout: {
                            padding: 20,
                        }
                    },
                    plugins: [ChartDataLabels]
                });
            });
    });






    $(document).ready(function () {
        $.ajax({
            url: 'dashbourd.aspx/users',
            data: {},
            dataType: 'json',
            type: 'POST',
            contentType: 'application/json',
            success: function (response) {
                // Assuming your response structure
                var rowCount = response.d;

                // Update the element where you want to display the count
                $("#employees").text(rowCount);


            },
            error: function (response) {
                alert(response.responseText);
            }
        });

    });





    $(document).ready(function () {
        $.ajax({
            url: 'dashbourd.aspx/houses',
            data: {},
            dataType: 'json',
            type: 'POST',
            contentType: 'application/json',
            success: function (response) {
                // Assuming your response structure
                var rowCount = response.d;

                // Update the element where you want to display the count
                $("#houses").text(rowCount);


            },
            error: function (response) {
                alert(response.responseText);
            }
        });

    });



</script>



</asp:Content>
