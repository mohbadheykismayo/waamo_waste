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
<%--<!-- Modal -->
<div class="modal fade" id="stockmodal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg"> <!-- Add modal-lg for large modal -->
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header bg-gradient-primary text-white">
                <h5 class="modal-title" id="staticBackdropLabel1">Ku Dar Waax, Kana Badal</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <!-- Page Header -->
                <div class="page-header mb-3">
                    <div class="page-title text-center">
                        <h4 class="text-primary fw-bold">Add Items to Stock</h4>
                    </div>
                </div>

                <!-- Card -->
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped" id="shaqale">
                                        <thead>
                                            <tr>
                                                <th>Full Name</th>
                                                <th>Guri Number</th>
                                                <th>Xaafada</th>
                                                <th>Waaxda</th>
                                                <th>Number</th>
                                                <th>GPS Longitude</th>
                                                <th>GPS Latitude</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Tabs Section -->
                        <ul class="nav nav-tabs justify-content-center mt-4" id="stockTab" role="tablist">
                            <li class="nav-item">
                                <button class="nav-link active" id="tab1-tab" data-bs-toggle="tab" data-bs-target="#tab1-content" type="button" role="tab" aria-controls="tab1-content" aria-selected="true">Xaafada</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" id="tab2-tab" data-bs-toggle="tab" data-bs-target="#tab2-content" type="button" role="tab" aria-controls="tab2-content" aria-selected="false">Supplier Info</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" id="tab3-tab" data-bs-toggle="tab" data-bs-target="#tab3-content" type="button" role="tab" aria-controls="tab3-content" aria-selected="false">Purchase History</button>
                            </li>
                        </ul>

                        <!-- Tab Content -->
                        <div class="tab-content mt-4" id="stockTabContent">
                            <!-- Tab 1 Content -->
                            <div class="tab-pane fade show active" id="tab1-content" role="tabpanel" aria-labelledby="tab1-tab">
                                <button class="btn btn-outline-primary w-100 mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTab1" aria-expanded="false" aria-controls="collapseTab1">
                                    Show/Hide Xaafadaha iyo Waaxyaha
                                </button>
                                <div class="collapse" id="collapseTab1">
                                    <div class="card card-body border-primary">
                                        <div class="page-btn">
                                            <a href="#" class="btn btn-outline-primary btn-added" onclick="callmodal()">
                                                <img src="assets/img/icons/plus.svg" class="me-1" alt="img">Ku Dar Xaafad
                                            </a>
                                        </div>
                                        <div id="map-container">
                                            <div id="map" style="height: 400px;"></div> <!-- Map container -->
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tab 2 Content -->
                            <div class="tab-pane fade" id="tab2-content" role="tabpanel" aria-labelledby="tab2-tab">
                                <button class="btn btn-outline-success w-100 mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTab2" aria-expanded="false" aria-controls="collapseTab2">
                                    Show/Hide Supplier Info
                                </button>
                                <div class="collapse" id="collapseTab2">
                                    <iframe src="https://www.google.com/maps/embed?pb=!1m17!1m12!1m3!1d759.7649610407138!2d42.53952416468832!3d-0.3587674345167579!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m2!1m1!2zMMKwMjEnMzEuNyJTIDQywrAzMicyMi4yIkU!5e1!3m2!1sen!2sso!4v1729019983702!5m2!1sen!2sso" width="100%" height="650" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                </div>
                            </div>

                            <!-- Tab 3 Content -->
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

            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-lg" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-lg">Save Changes</button>
            </div>
        </div>
    </div>
</div>--%>

<!-- Beautiful and Eye-Catching Modal with Full-Sized Tabs for Map and Table -->
<div class="modal fade" id="tabModal" tabindex="-1" aria-labelledby="tabModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tabModalLabel">House Details and Map</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Tabs Navigation -->
                <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="table-tab" data-bs-toggle="tab" data-bs-target="#table-content" type="button" role="tab" aria-controls="table-content" aria-selected="true">Table</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="map-tab" data-bs-toggle="tab" data-bs-target="#map-content" type="button" role="tab" aria-controls="map-content" aria-selected="false">Map</button>
                    </li>
                </ul>

                <!-- Tabs Content -->
                <div class="tab-content" id="myTabContent">
                    <!-- Table Tab -->
                    <div class="tab-pane fade show active" id="table-content" role="tabpanel" aria-labelledby="table-tab">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped" id="shaqale">
                                <thead>
                                    <tr>
                                        <th>Full Name</th>
                                        <th>Guri Number</th>
                                        <th>Xaafada</th>
                                        <th>Waaxda</th>
                                        <th>Number</th>
                                        <th>GPS Longitude</th>
                                        <th>GPS Latitude</th>
                                        <th>Status</th>
                                              <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- You can dynamically populate the table here -->
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Map Tab -->
                    <div class="tab-pane fade" id="map-content" role="tabpanel" aria-labelledby="map-tab">
                        <div id="map-container">
                            <div id="map"></div> <!-- Map container -->
                            <iframe class="map-responsive" src="https://www.google.com/maps/embed?pb=!1m17!1m12!1m3!1d759.7649610407138!2d42.53952416468832!3d-0.3587674345167579!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m2!1m1!2zMMKwMjEnMzEuNyJTIDQywrAzMicyMi4yIkU!5e1!3m2!1sen!2sso!4v1729019983702!5m2!1sen!2sso" width="1500"   allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>
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
                    <a href="#" class="btn btn-added" id="openHouseModal">
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

   <!-- Beautiful Horizontal Modal -->
  <div class="modal fade" id="houseModal" tabindex="-1" aria-labelledby="houseModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="houseModalLabel">Add New House</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
         
            <!-- House Number -->
            <div class="form-group">
              <label for="houseNumber" class="form-label">House Number</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-home"></i></span>
                <input type="text" class="form-control" id="houseNumber" name="houseNumber" required>
              </div>
            </div>

          <%--  <!-- SubNeighborhood ID -->
            <div class="form-group">
              <label for="subNeighborhoodID" class="form-label">Sub Neighborhood ID</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                <input type="text" class="form-control" id="subNeighborhoodID" name="subNeighborhoodID" required>
              </div>
            </div>--%>
                <!-- SubNeighborhood ID (Dropdown populated via AJAX) -->
        <div class="form-group">
          <label for="itemdrop" class="form-label">Sub Neighborhood ID</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
            <select class="form-select" id="itemdrop" name="subNeighborhoodID" required>
              <option selected="selected" value="0">Please select</option>
              <!-- Options will be populated dynamically -->
            </select>
          </div>
        </div>

        <!-- Waaxda (Dropdown populated via AJAX) -->
        <div class="form-group">
          <label for="waxda" class="form-label">Waaxda</label>
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
            <select class="form-select" id="waxda" name="waaxda" required>
              <option selected="selected" value="0">Please select</option>
              <!-- Options will be populated dynamically -->
            </select>
          </div>
        </div>

            <!-- Street -->
            <div class="form-group">
              <label for="street" class="form-label">Street</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-road"></i></span>
                <input type="text" class="form-control" id="street" name="street" required>
              </div>
            </div>

            <!-- City -->
            <div class="form-group">
              <label for="city" class="form-label">City</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-city"></i></span>
                <input type="text" class="form-control" id="city" name="city" required>
              </div>
            </div>

            <!-- State -->
            <div class="form-group">
              <label for="state" class="form-label">State</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-flag"></i></span>
                <input type="text" class="form-control" id="state" name="state" required>
              </div>
            </div>

            <!-- Postal Code -->
            <div class="form-group">
              <label for="postalCode" class="form-label">Postal Code</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-mail-bulk"></i></span>
                <input type="text" class="form-control" id="postalCode" name="postalCode" required>
              </div>
            </div>

            <!-- GPS Latitude -->
            <div class="form-group">
              <label for="gpsLatitude" class="form-label">GPS Latitude</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-map-pin"></i></span>
                <input type="text" class="form-control" id="gpsLatitude" name="gpsLatitude">
              </div>
            </div>

            <!-- GPS Longitude -->
            <div class="form-group">
              <label for="gpsLongitude" class="form-label">GPS Longitude</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-map-pin"></i></span>
                <input type="text" class="form-control" id="gpsLongitude" name="gpsLongitude">
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
            <!-- Full Name -->
            <div class="form-group">
              <label for="fullname" class="form-label">Full Name</label>
              <div class="input-group">
                <span class="input-group-text"><i class="fas fa-user"></i></span>
                <input type="text" class="form-control" id="fullname" name="fullname" required>
              </div>
            </div>
            <div class="form-group">
  <label for="amount" class="form-label">Amount</label>
  <div class="input-group">
    <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
    <input type="number" class="form-control" id="amount" name="amount" required>
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
          <button type="button" class="btn btn-primary" id="saveHouseButton">Save House</button>
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
                            houseNumber: $('#houseNumber').val(),
                     
                            waaxda: $('#waxda').val(),
                            street: $('#street').val(),
                            city: $('#city').val(),
                            state: $('#state').val(),
                            postalCode: $('#postalCode').val(),
                            gpsLatitude: $('#gpsLatitude').val(),
                            gpsLongitude: $('#gpsLongitude').val(),
                            isActive: $('#isActive').val(),
                            fullname: $('#fullname').val(),
                            number: $('#number').val(),
                            amount: $('#amount').val(),
                            date: $('#date').val()
                        };

                        // Make AJAX call to save data to the server
                        $.ajax({
                            type: "POST",
                            url: "houses.aspx/SaveHouseDetails",
                            data: JSON.stringify(houseData),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                try {
                                    // Check if the response contains a success message
                                    if (response.d === "Success") {
                                        alert("House details saved successfully!");
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
                if ($('#houseNumber').val() === "") {
                    $('#houseNumber').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#houseNumber').removeClass('is-invalid');
                }

                if ($('#itemdrop').val() === "0") { // Ensure that an item is selected
                    $('#itemdrop').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#itemdrop').removeClass('is-invalid');
                }

                if ($('#waxda').val() === "0") { // Ensure that a waaxda is selected
                    $('#waxda').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#waxda').removeClass('is-invalid');
                }

                if ($('#amount').val() === "" || $('#amount').val() <= 0) {
                    $('#amount').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#amount').removeClass('is-invalid');
                }

                if ($('#street').val() === "") {
                    $('#street').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#street').removeClass('is-invalid');
                }

                if ($('#city').val() === "") {
                    $('#city').addClass('is-invalid');
                    isValid = false;
                } else {
                    $('#city').removeClass('is-invalid');
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
            // When itemdrop changes, load the waxda dropdown
            $('#itemdrop').change(function () {
                var search = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "users.aspx/getwax",
                    data: JSON.stringify({ 'search': search }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var waxda = $('#waxda');
                        waxda.empty().append('<option selected="selected" value="0">Please select</option>');
                        $.each(r.d, function () {
                            waxda.append($('<option></option>').val(this['Value']).html(this['Text']));
                        });
                    },
                    error: function (error) {
                        console.log("Error loading Waaxda: ", error);
                    }
                });
            });

            // Load the Sub Neighborhood dropdown on page load
            getxafad();

            function getxafad() {
                $.ajax({
                    type: "POST",
                    url: "crudneighbourhoods.aspx/getxafad",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        var itemdrop = $('#itemdrop');
                        itemdrop.empty().append('<option selected="selected" value="0">Please select</option>');
                        $.each(r.d, function () {
                            itemdrop.append($('<option></option>').val(this['Value']).html(this['Text']));
                        });
                    },
                    error: function (error) {
                        console.log("Error loading Sub Neighborhoods: ", error);
                    }
                });
            }
        });


        $(document).ready(function () {
            $('#openHouseModal').click(function () {
                $('#houseModal').modal('show');
            });
        });

        $('#tabModal').on('shown.bs.modal', function () {
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


            $('#tabModal').modal('show');


        });

    </script>

</asp:Content>
