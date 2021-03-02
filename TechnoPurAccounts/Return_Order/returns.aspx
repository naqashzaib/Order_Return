<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="returns.aspx.cs" Inherits="TechnoPurAccounts.returns" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add Companies</title>
    <script>
        $(document).ready(function () {
            //html styles
            $('button').css('border-radius', '0px');
            $('input').css('border-radius', '0px');
            $('.modal-content').css('border-radius', '0px');
            $(document).on('click', '#btnAddstd', function () {
                $('#btnaddstd').show();
                $('#btnupdaterec').hide();
                $('#insertHead').show();
                $('#updateHead').hide();
                clearallbox();

            });
            showStdInfo();

            //Insert Teacher Info Script




            $('#btnaddstd').on('click', function () {
                var btn = $(this);
                btn.prop('disabled', true);
                setTimeout(function () {
                    btn.prop('disabled', false);
                }, 1000);
                if ($('#ddlCompany').val() == "") {
                    toastr["error"]("Select Company name");
                    $('#ddlCompany').focus();
                    return false;
                }
                if ($('#txtCustomerName').val() == "") {
                    toastr["error"]("Enter Customer Name");
                    $('#txtCustomerName').focus();
                    return false;
                }
                if ($('#txtrma').val() == "") {
                    toastr["error"]("Enter RMA");
                    $('#txtrma').focus();
                    return false;
                }

                if ($('#txtNote').val() == "") {
                    toastr["error"]("Enter Note");
                    $('#txtNote').focus();
                    return false;
                }

                if (imgUrl == "") {
                    toastr["error"]("Select Attachment");
                    return false;
                }
                var clsCompanyInsert = {};
                clsCompanyInsert.company_id = $('#ddlCompany').val();
                clsCompanyInsert.customer_name = $('#txtCustomerName').val();
                clsCompanyInsert.rma = $('#txtrma').val();
                clsCompanyInsert.note = $('#txtNote').val();
                clsCompanyInsert.created_time = new Date();
                clsCompanyInsert.created_time = new Date();
                clsCompanyInsert.attachment = imgUrl;

                $.ajax({
                    headers: {
                        "Authorization": localStorage["access_token"]
                    },
                    url: url + "api/ReturnInsert",
                    async: false,
                    method: 'POST',
                    contentType: 'application/json;charset=utf-8',
                    data: JSON.stringify(clsCompanyInsert),
                    success: function (data) {

                        clearallbox();
                        swal({
                            title: "Done",
                            text: "Return Added, Return no. is R-" + data,
                            icon: "success",
                        });
                        showStdInfo();
                        $('#myModal').modal('toggle');

                    },
                    error: function (jqXHR, exception) {
                        if (jqXHR.status == 302) {
                            toastr["info"](jqXHR.responseJSON);
                        }
                        else {
                            toastr["error"]("Internal server error <b>[500]</b> occured");

                        }
                    }
                });
            });

            //Get data in pop-up
            var company_id;

            $('#btnupdaterec').on('click', function () {
                var btn = $(this);
                btn.prop('disabled', true);
                setTimeout(function () {
                    btn.prop('disabled', false);
                }, 1000);
                if ($('#ddlCompany').val() == "") {
                    toastr["error"]("Select Company name");
                    $('#ddlCompany').focus();
                    return false;
                }
                if ($('#txtCustomerName').val() == "") {
                    toastr["error"]("Enter Customer Name");
                    $('#txtCustomerName').focus();
                    return false;
                }
                if ($('#txtrma').val() == "") {
                    toastr["error"]("Enter RMA");
                    $('#txtrma').focus();
                    return false;
                }

                if ($('#txtNote').val() == "") {
                    toastr["error"]("Enter Note");
                    $('#txtNote').focus();
                    return false;
                }
               
                if (imgUrl == "") {
                    toastr["error"]("Select Attachment");
                    return false;
                }
                var clsCompanyInsert = {};
                clsCompanyInsert.company_id = $('#ddlCompany').val();
                clsCompanyInsert.customer_name = $('#txtCustomerName').val();
                clsCompanyInsert.rma = $('#txtrma').val();
                clsCompanyInsert.note = $('#txtNote').val();
                clsCompanyInsert.created_time = new Date();
                clsCompanyInsert.created_time = new Date();
                clsCompanyInsert.attachment = imgUrl;

                $.ajax({
                    headers: {
                        "Authorization": localStorage["access_token"]
                    },
                    url: url + "api/ReturnInsert",
                    async: false,
                    method: 'PUT',
                    contentType: 'application/json;charset=utf-8',
                    data: JSON.stringify(clsCompanyInsert),
                    success: function (data) {

                        clearallbox();
                        swal({
                            title: "Done",
                            text: "Company info Succefully Updated",
                            icon: "success",
                        });
                        showStdInfo();
                        $('#myModal').modal('toggle');

                    },
                    error: function (jqXHR, exception) {
                        if (jqXHR.status == 302) {
                            toastr["info"](jqXHR.responseJSON);
                        }
                        else {
                            toastr["error"]("Internal server error <b>[500]</b> occured");

                        }
                    }
                });
            });


            $(document).on('click', '.editStdInfo', function () {
                $('#btnaddstd').hide();
                $('#btnupdaterec').show();
                $('#insertHead').hide();
                $('#updateHead').show();
                company_id = ($(this).attr("id"));
                var $tr = $(this).closest('tr');
                $('#txtcompany').val($tr.find('td:nth-child(2)').text());
                $('#txtusername').val($tr.find('td:nth-child(3)').text());
                $('#txtemail').val($tr.find('td:nth-child(4)').text());
                $('#txtpassword').val($tr.find('td:nth-child(5)').attr('id'));
                $('#txtstdphone').val($tr.find('td:nth-child(6)').text());
            });

            //Update Teacher info
            //Delete Teacher info
            $(document).on('click', '.delstdinfo', function () {
                var company_id = ($(this).attr("id"));
                if (confirm("Are you really want to delete this Return?") == true) {
                    $.ajax({
                        headers: {
                            "Authorization": localStorage["access_token"]
                        },
                        url: url + "api/ReturnDelete?id=" + company_id,
                        async: false,
                        method: 'Delete',
                        success: function (data) {
                            swal({
                                title: "Done",
                                text: "Return Successfully Deleted",
                                icon: "success",
                            });
                            showStdInfo();
                        },
                        error: function (jqXHR, exception) {
                            if (jqXHR.status == 302) {
                                toastr["info"](jqXHR.responseJSON);
                            }
                            else {
                                toastr["error"]("Internal server error <b>[500]</b> occured");

                            }
                        }
                    });
                    return true;
                }
                else {
                    swal({
                        text: "Teacher info is saved.",
                        icon: "error",
                    });
                    return false;
                }
            });
            $(document).on('click', '.clsViewReturn', function () {
                var $tr = $(this).closest('tr');
                var attachmentlink = $(this).attr('name');

                $('#lblReturnNo').text($tr.find('td:nth-child(2)').text());
                $('#lblCompany').text($tr.find('td:nth-child(4)').text());
                $('#lblCustomer').text($tr.find('td:nth-child(5)').text());
                $('#lvlRMA').text($tr.find('td:nth-child(6)').text());
                $('#lblNote').text($tr.find('td:nth-child(7)').text());
                $('#divImg').html('<a target="_blank" href="' + url  + attachmentlink +'"><img src="' + attachmentlink +'" height="40px" alt="Return Attcahment" /></a>');
            });
           $(document).on('change', '#txtAttachment', function () {
                alert(this.files[0].name);
                $('#btnUploadFile').removeAttr('hidden');
               
               
            });
            $('#btnUploadFile').on('click', function () {
                var data = new FormData()
                var files = $("#txtAttachment").get(0).files;
                // Add the uploaded image content to the form data collection  
                if (files.length > 0) {
                    data.append("UploadedImage", files[0]);
                }
                // Make Ajax request with the contentType = false, and procesDate = false  
                var ajaxRequest = $.ajax({
                    type: "POST",
                    method: "POST",
                    url: url +"api/PostFileUpload",
                    contentType: false,
                    processData: false,
                    data: data
                });
                ajaxRequest.done(function (xhr, textStatus) {
                    $('#btnUploadFile').prop('value', 'Uploaded');
                    $('#btnUploadFile').prop('disabled', false);
                    imgUrl=xhr
                });
            });
            var imgUrl = "";
            showCompaniesNames();

       });


        function clearallbox() {
            $('#txtcompany').val("");
            $('#txtusername').val("");
            $('#txtstdphone').val("");
            $('#txtemail').val("");
            $('#txtpassword').val("");
        }

       
        //showing Teacher info in table
        function showCompaniesNames() {
            $.ajax({
                headers: {
                    "Authorization": localStorage["access_token"]
                },
                url: url + "api/GetCompany",
                async: false,
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    var voucherOptions = $('#ddlCompany');
                    voucherOptions.empty();
                    $('#ddlCompany').append('<option value="-1">Select company name</option>')

                    $(data).each(function (index, infostd) {
                        $('#ddlCompany').append('<option value="' + infostd.company_id + '">' + infostd.name + '</option>')
                        //voucherOptions.append('<tr><td>' + (index + 1) + '</td> <td>' + infostd.name + '</td><td>' + infostd.username + '</td> <td>' + infostd.email + '</td><td id="' + infostd.password + '">*****</td><td>' + infostd.phone + '</td> <td><button type="button" class="btn btn-info editStdInfo" data-toggle="modal" data-target="#myModal" style="border-radius:0px;"  id="' + infostd.company_id + '"><i class="icon-pencil"></i></button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-danger delstdinfo" style="border-radius:0px;" id="' + infostd.company_id + '" ><i class="icon-trash"></i></button></td> </tr>');
                    });
                },
                error: function (jqXHR, exception) {
                    msg = 'Internal Server Error [500].';
                    swal({
                        type: 'error',
                        title: 'Oops...',
                        text: msg,
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            });
        }
           function showStdInfo() {
            $.ajax({
                headers: {
                    "Authorization": localStorage["access_token"]
                },
                url: url + "api/GetReturns",
                async: false,
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    var voucherOptions = $('#tablerows');
                    voucherOptions.empty();

                    $(data).each(function (index, infostd) {
                        voucherOptions.append('<tr><td>' + (index + 1) + '</td> <td>R-' + infostd.c1.reaturn_order_id + '</td><td>' + infostd.c1.created_datetime + '</td> <td>' + infostd.name + '</td><td>' + infostd.c1.customer_name + '</td><td>' + infostd.c1.rma + '</td><td>' + infostd.c1.note + '</td><td>' + infostd.c1.status + '</td><td><button type="button" class="btn btn-success clsViewReturn" data-toggle="modal" data-target="#myModal1" style="border-radius:0px;"  id="' + infostd.c1.reaturn_order_id + '" name="' + infostd.c1.attachment+'"><i class="icon-eye"></i></button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-danger delstdinfo" style="border-radius:0px;" id="' + infostd.c1.reaturn_order_id + '" ><i class="icon-trash"></i></button></td> </tr>');
                    });
                },
                error: function (jqXHR, exception) {
                    msg = 'Internal Server Error [500].';
                    swal({
                        type: 'error',
                        title: 'Oops...',
                        text: msg,
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            });
        }
       function isEmail(email) {
            var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            return regex.test(email);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Begin page -->
    <div id="wrapper">
        <div class="content-page">
            <div class="content">

                <!-- Start Content-->
                <div class="container-fluid">

                    <!-- start page title -->
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box">
                                <h4 class="page-title">Add Returns</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title -->
                    <hr />
                    <button type="button" style="background: #1a2942; color: #ffffff" class="btn" id="btnAddstd" data-toggle="modal" data-target="#myModal">Add New Return</button>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body table-responsive">
                                    <table id="" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">

                                        <thead>
                                            <th style="width: 6%;">Sr#</th>
                                            <th>Return No.</th>
                                            <th>Datetime</th>
                                            <th>Company Name</th>
                                            <th>Customer Name</th>
                                            <th>RMA</th>
                                            <th>Notes</th>
                                            <th>Status</th>
                                            <th>View/Edit/Delete</th>
                                        </thead>
                                        <tbody id="tablerows">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>


            </div>


        </div>
        <div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="insertHead"><strong>Add Return</strong></h4>
                        <h4 class="modal-title" id="updateHead"><strong>Edit Return</strong></h4>
                        <!--<button type="button" class="close pull-right" data-dismiss="modal" aria-hidden="true">×</button>-->
                    </div>
                    <div class="modal-body">
                        <form class="" action="#" autocomplete="off" method="post">

                            <div class="form-group">
                                <label for="fname">Company Name</label>
                                <select id="ddlCompany" class="form-control">
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="fname">Customer Name<span class="text-danger">*</span></label>
                                <input id="txtCustomerName" type="text" name="" placeholder="Enter Customer Name" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="fname">RMA<span class="text-danger">*</span></label>
                                <input id="txtrma" type="text" placeholder="Enter RMA" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="fname">Note<span class="text-danger">*</span></label>
                                <textarea id="txtNote" placeholder="Enter Note.." class="form-control" rows="2">

                                 </textarea>
                            </div>
                            <div class="form-group">
                                <label for="phone">Attachment<span class="text-danger">*</span></label>
                                <input id="txtAttachment" type="file" name="files" />
                                <input id="btnUploadFile" type="button" hidden="hidden" value="Upload File" class="btn-primary" />

                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="btnaddstd">Save</button>
                        <button type="button" class="btn btn-info" id="btnupdaterec">Update</button>
                    </div>

                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <div id="myModal1" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display: none;" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <!--<button type="button" class="close pull-right" data-dismiss="modal" aria-hidden="true">×</button>-->
                    </div>
                    <div class="modal-body">
                        <form class="" action="#" autocomplete="off" method="post">

                            <div class="form-group">
                                <label for="fname">Return No.: </label>
                           <p id="lblReturnNo"></p>
                            </div>                            <div class="form-group">
                                <label for="fname">Company Name: </label>
                           <p id="lblCompany"></p>
                            </div>
                            <div class="form-group">
                                <label for="fname">Customer Name: </label>
                           <p id="lblCustomer"></p>
                           
                                </div>
                            <div class="form-group">
                                <label for="fname">RMA:</label>
                           <p id="lvlRMA"></p> </div>
                            <div class="form-group">
                                <label for="fname">Note:</label>
                           <p id="lblNote"></p>
                            </div>
                            <div class="form-group">
                                <label for="phone">Attachment</label>
                               <div id="divImg"></div>
                                
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Cancel</button>
                   
                    </div>

                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </div>
    <!-- sample modal content -->

    <!-- /.modal -->
    <!-- END wrapper -->
</asp:Content>

