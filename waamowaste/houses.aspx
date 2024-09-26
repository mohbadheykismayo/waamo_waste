<%@ Page Title="" Language="C#" MasterPageFile="~/home.Master" AutoEventWireup="true" CodeBehind="houses.aspx.cs" Inherits="waamowaste.houses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
    <script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css" />
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

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Modal -->
<div class="modal fade" id="stockmodal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content ">
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
                                    <table class="table" id="shaqale">
                                        <thead>
                                            <tr>
                                                <th>fullname</th>
                                                <th>guri number</th>
                                                <th>xaafada</th>
                                                <th>waaxda</th>
                                                <th>number ka</th>
                                                <th>GPSLongitude ka</th>
                                                <th>GPSLatitude ka</th>
                                                <th>xaalada</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
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
                                    Show/Hide Xaafadaha iyo Waaxyaha
                                </button>
                                <div class="collapse" id="collapseTab1">
                                    <div class="card card-body border-primary">
                                        <div class="page-btn">
                                            <a href="#" class="btn  btn-outline-primary btn-added" onclick="callmodal()">
                                                <img src="assets/img/icons/plus.svg" class="me-1" alt="img">Ku Dar Xaafad
                                            </a>
                                        </div>
                                        <div id="map-container">
                                            <div id="map" style="height: 400px;"></div> <!-- Map container -->
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

    <div class="row">
        <div class="col-lg-8 col-md-12">
            <div class="page-header">
                <div class="page-title">
                    <h4>Magacyada guryaha </h4>

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
                                    <span>
                                        <img src="assets/img/icons/closes.svg" alt="img"></span>
                                </a>
                            </div>
                            <div class="search-input">
                                <a class="btn btn-searchset">
                                    <img src="assets/img/icons/search-white.svg" alt="img"></a>
                            </div>
                        </div>
                        <div class="wordset">
                            <ul>
                                <li>
                                    <a data-bs-toggle="tooltip" data-bs-placement="top" title="pdf">
                                        <img src="assets/img/icons/pdf.svg" alt="img"></a>
                                </li>
                                <li>
                                    <a data-bs-toggle="tooltip" data-bs-placement="top" title="excel">
                                        <img src="assets/img/icons/excel.svg" alt="img"></a>
                                </li>
                                <li>
                                    <a data-bs-toggle="tooltip" data-bs-placement="top" title="print">
                                        <img src="assets/img/icons/printer.svg" alt="img"></a>
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
                                        <a class="btn btn-filters ms-auto">
                                            <img src="assets/img/icons/search-whites.svg" alt="img"></a>
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
                                     <th>guri number</th>
                                    <th>xaafada</th>
                                    <th>waaxda</th>
                                    <th>number ka</th>
                                    <th>xaalada</th>
                                


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
                    <h4>Magacyada Xaafadaha </h4>

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
                                    <span>
                                        <img src="assets/img/icons/closes.svg" alt="img"></span>
                                </a>
                            </div>
                            <div class="search-input">
                                <a class="btn btn-searchset">
                                    <img src="assets/img/icons/search-white.svg" alt="img"></a>
                            </div>
                        </div>
                        <div class="wordset">
                            <ul>
                                <li>
                                    <a data-bs-toggle="tooltip" data-bs-placement="top" title="pdf">
                                        <img src="assets/img/icons/pdf.svg" alt="img"></a>
                                </li>
                                <li>
                                    <a data-bs-toggle="tooltip" data-bs-placement="top" title="excel">
                                        <img src="assets/img/icons/excel.svg" alt="img"></a>
                                </li>
                                <li>
                                    <a data-bs-toggle="tooltip" data-bs-placement="top" title="print">
                                        <img src="assets/img/icons/printer.svg" alt="img"></a>
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
                                        <a class="btn btn-filters ms-auto">
                                            <img src="assets/img/icons/search-whites.svg" alt="img"></a>
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
        $('#stockmodal').on('shown.bs.modal', function () {
            setTimeout(function () {
                map.invalidateSize(); // Fix the sizing for Leaflet
            }, 100); // Small delay to ensure the modal is fully rendered
        });

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






     


        $("#datatable").on("click", ".edit-button", function (event) {
            event.preventDefault(); // Prevent default behavior

            var row = $(this).closest("tr");
            var id = $(this).data("id");


            var name = row.find("td:nth-child(1)").text();

            $("#id").val(id);
            $("#catname").val(name);


            //$.ajax({
            //    url: 'houses.aspx/datadisplay1',
            //    data: "{'id':'" + id + "' }",
            //    dataType: "json",
            //    type: 'POST',
            //    contentType: "application/json",
            //    success: function (response) {
            //        console.log(response)


            //        $("#shaqale tbody").empty();

            //        for (var i = 0; i < response.d.length; i++) {
            //            var NeighborhoodName = response.d[i].NeighborhoodName;
            //            var SubNeighborhoodName = response.d[i].SubNeighborhoodName;
            //            var HouseNumber = response.d[i].HouseNumber;
            //            var IsActive = response.d[i].IsActive;

            //            var fullname = response.d[i].fullname;
            //            var number = response.d[i].number;
            //            var HouseID = response.d[i].HouseID;
            //            var GPSLongitude = response.d[i].GPSLongitude;
            //            var GPSLatitude = response.d[i].GPSLatitude;









            //            $("#shaqale tbody").append(
            //                "<tr>" +
            //                "<td>" + fullname + "</td>" +
            //                "<td>" + HouseNumber + "</td>" +
            //                "<td>" + NeighborhoodName + "</td>" +
            //                "<td>" + SubNeighborhoodName + "</td>" +
            //                "<td>" + number + "</td>" +
            //                "<td>" + GPSLongitude + "</td>" +
            //                "<td>" + GPSLatitude + "</td>" +
            //                "<td>" + IsActive + "</td>" +
            //                "<td>" +
            //                '<a class="me-3 edit-button" data-id="' + HouseID + '">' +
            //                '<img src="assets/img/icons/edit.svg" alt="Edit">' +
            //                '</a>' +
            //                '<a class="me-3 delete-btn" data-id="' + HouseID + '">' +
            //                '<img src="assets/img/icons/delete.svg" alt="Delete">' +
            //                '</a>' +
            //                "</td>" +
            //                "</tr>"
            //            );
            //        }


            //    },
            //    error: function (response) {
            //        alert(response.responseText);
            //    }
            //});

            //var map; // Declare the map globally

            //$.ajax({
            //    url: 'houses.aspx/datadisplay1',
            //    data: "{'id':'" + id + "' }",
            //    dataType: "json",
            //    type: 'POST',
            //    contentType: "application/json",
            //    success: function (response) {
            //        console.log(response);

            //        // Clear the table content
            //        $("#shaqale tbody").empty();

            //        // Remove the existing map instance and its container before creating a new map
            //        if (map !== undefined) {
            //            map.remove(); // Properly remove the map instance
            //        }
            //        // Reset the map container by replacing it with a new one
            //        $('#map').remove();  // Remove the map div
            //        $('#map-container').append('<div id="map" style="height: 400px;"></div>'); // Re-add the map div with a fixed height

            //        // Initialize the new Leaflet map instance
            //        map = L.map('map').setView([0, 0], 2); // Set default view
            //        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            //            attribution: '&copy; OpenStreetMap contributors'
            //        }).addTo(map);

            //        // Create bounds object to fit all markers later
            //        var bounds = L.latLngBounds();

            //        // Loop through the response data
            //        for (var i = 0; i < response.d.length; i++) {
            //            var NeighborhoodName = response.d[i].NeighborhoodName;
            //            var SubNeighborhoodName = response.d[i].SubNeighborhoodName;
            //            var HouseNumber = response.d[i].HouseNumber;
            //            var IsActive = response.d[i].IsActive;
            //            var fullname = response.d[i].fullname;
            //            var number = response.d[i].number;
            //            var HouseID = response.d[i].HouseID;
            //            var GPSLongitude = response.d[i].GPSLongitude;
            //            var GPSLatitude = response.d[i].GPSLatitude;

            //            // Add table rows
            //            $("#shaqale tbody").append(
            //                "<tr>" +
            //                "<td>" + fullname + "</td>" +
            //                "<td>" + HouseNumber + "</td>" +
            //                "<td>" + NeighborhoodName + "</td>" +
            //                "<td>" + SubNeighborhoodName + "</td>" +
            //                "<td>" + number + "</td>" +
            //                "<td>" + GPSLongitude + "</td>" +
            //                "<td>" + GPSLatitude + "</td>" +
            //                "<td>" + IsActive + "</td>" +
            //                "<td>" +
            //                '<a class="me-3 edit-button" data-id="' + HouseID + '">' +
            //                '<img src="assets/img/icons/edit.svg" alt="Edit">' +
            //                '</a>' +
            //                '<a class="me-3 delete-btn" data-id="' + HouseID + '">' +
            //                '<img src="assets/img/icons/delete.svg" alt="Delete">' +
            //                '</a>' +
            //                "</td>" +
            //                "</tr>"
            //            );

            //            // Update map with markers if GPS data is available
            //            if (GPSLatitude && GPSLongitude) {
            //                var marker = L.marker([GPSLatitude, GPSLongitude]).addTo(map)
            //                    .bindPopup(fullname + " - House " + HouseNumber);

            //                // Extend bounds to include each marker's position
            //                bounds.extend([GPSLatitude, GPSLongitude]);
            //            }
            //        }

            //        // Fit the map view to the bounds of all markers
            //        if (bounds.isValid()) {
            //            map.fitBounds(bounds); // Adjust zoom and center to fit all markers
            //        } else {
            //            alert("No valid GPS coordinates found.");
            //        }
            //    },
            //    error: function (response) {
            //        alert(response.responseText);
            //    }
            //});





            var map; // Declare the map globally

            $.ajax({
                url: 'houses.aspx/datadisplay1',
                data: "{'id':'" + id + "' }",
                dataType: "json",
                type: 'POST',
                contentType: "application/json",
                success: function (response) {
                    console.log(response);

                    // Clear the table content
                    $("#shaqale tbody").empty();
                    // Check if the map exists and remove it if it does
                    if (map !== undefined) {
                        map.remove(); // Properly remove the map instance
                    }

                    // Remove the old map div and append a fresh one
                    $('#map').remove();  // Remove the map div entirely
                    $('#map-container').append('<div id="map" style="height: 400px;"></div>'); // Create a new one

                    // Initialize the new Leaflet map instance
                    map = L.map('map').setView([0, 0], 2); // Default view
                    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                        maxZoom: 19,  // Ensuring max zoom
                        attribution: '&copy; OpenStreetMap contributors'
                    }).addTo(map);

                    // Bounds object to fit all markers later
                    var bounds = L.latLngBounds();

                    // Create bounds object to fit all markers later
                    var bounds = L.latLngBounds();

                    // Loop through the response data
                    for (var i = 0; i < response.d.length; i++) {
                        var NeighborhoodName = response.d[i].NeighborhoodName;
                        var SubNeighborhoodName = response.d[i].SubNeighborhoodName;
                        var HouseNumber = response.d[i].HouseNumber;
                        var IsActive = response.d[i].IsActive;
                        var fullname = response.d[i].fullname;
                        var number = response.d[i].number;
                        var HouseID = response.d[i].HouseID;
                        var GPSLongitude = parseFloat(response.d[i].GPSLongitude); // Ensure longitude is a number
                        var GPSLatitude = parseFloat(response.d[i].GPSLatitude);   // Ensure latitude is a number

                        // Add table rows
                        $("#shaqale tbody").append(
                            "<tr>" +
                            "<td>" + fullname + "</td>" +
                            "<td>" + HouseNumber + "</td>" +
                            "<td>" + NeighborhoodName + "</td>" +
                            "<td>" + SubNeighborhoodName + "</td>" +
                            "<td>" + number + "</td>" +
                            "<td>" + GPSLongitude + "</td>" +
                            "<td>" + GPSLatitude + "</td>" +
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
                        if (GPSLatitude && GPSLongitude) {
                            var marker = L.marker([GPSLatitude, GPSLongitude]).addTo(map)
                                .bindPopup(fullname + " - House " + HouseNumber);

                            // Extend bounds to include this marker
                            bounds.extend([GPSLatitude, GPSLongitude]);
                        }

                    }

                    // Fit the map view to the bounds of all markers
                    if (bounds.isValid()) {
                        map.fitBounds(bounds); // Zoom and center to fit all markers
                    } else {
                        alert("No valid GPS coordinates found.");
                    }

                },
                error: function (response) {
                    alert(response.responseText);
                }
            });


            $('#stockmodal').modal('show');


        });

    </script>

</asp:Content>
