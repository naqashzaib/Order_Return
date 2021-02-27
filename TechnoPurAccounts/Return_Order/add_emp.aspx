<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="add_emp.aspx.cs" Inherits="TechnoPurAccounts.Return_Order.add_emp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title>Add Employee</title>
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
                if ($('#txtcompany').val() == "") {
                    toastr["error"]("Employee name is required");
                    $('#txtcompany').focus();
                    return false;
                }
                if ($('#username').val() == "") {
                    toastr["error"]("User Name is required");
                    $('#username').focus();
                    return false;
                }
                if ($('#txtemail').val() == "") {
                    toastr["error"]("E-mail is required");
                    $('#txtemail').focus();
                    return false;
                }
              
                if (!isEmail($('#txtemail').val())) {

                    toastr["error"]("Please Enter E-mail Formate Correct");
                    $('#txtemail').focus();
                    return false;
                }
                if ($('#txtpassword').val() == "") {
                    toastr["error"]("Password is required");
                    $('#txtpassword').focus();
                    return false;
                }
                if ($('#txtstdphone').val() == "") {
                    toastr["error"]("Phone number is required");
                    $('#txtstdphone').focus();
                    return false;
                }
                var clsCompanyInsert = {};
                clsCompanyInsert.name = $('#txtcompany').val();
                clsCompanyInsert.username = $('#txtusername').val();
                clsCompanyInsert.password = $('#txtpassword').val();
                clsCompanyInsert.email = $('#txtemail').val();
                clsCompanyInsert.phone = $('#txtstdphone').val();
                $.ajax({
                    headers: {
                        "Authorization": localStorage["access_token"]
                    },
                    url: url + "api/EmployeeInsert",
                    async: false,
                    method: 'POST',
                    contentType: 'application/json;charset=utf-8',
                    data: JSON.stringify(clsCompanyInsert) ,
                    success: function (data) {

                        clearallbox();
                        swal({
                            title: "Done",
                            text: "Employee info succefully saved",
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
                if ($('#txtcompany').val() == "") {
                    toastr["error"]("Employee name is required");
                    $('#txtcompany').focus();
                    return false;
                }
                if ($('#username').val() == "") {
                    toastr["error"]("User Name is required");
                    $('#username').focus();
                    return false;
                }
                if ($('#txtemail').val() == "") {
                    toastr["error"]("E-mail is required");
                    $('#txtemail').focus();
                    return false;
                }

                if (!isEmail($('#txtemail').val())) {

                    toastr["error"]("Please Enter E-mail Formate Correct");
                    $('#txtemail').focus();
                    return false;
                }
                if ($('#txtpassword').val() == "") {
                    toastr["error"]("Password is required");
                    $('#txtpassword').focus();
                    return false;
                }
                if ($('#txtstdphone').val() == "") {
                    toastr["error"]("Phone number is required");
                    $('#txtstdphone').focus();
                    return false;
                }
                var clsCompanyInsert = {};
                clsCompanyInsert.name = $('#txtcompany').val();
                clsCompanyInsert.username = $('#txtusername').val();
                clsCompanyInsert.password = $('#txtpassword').val();
                clsCompanyInsert.email = $('#txtemail').val();
                clsCompanyInsert.phone = $('#txtstdphone').val();
                clsCompanyInsert.company_id = company_id;
                
                $.ajax({
                    headers: {
                        "Authorization": localStorage["access_token"]
                    },
                    url: url + "api/EmployeeUpdate",
                    async: false,
                    method: 'PUT',
                    contentType: 'application/json;charset=utf-8',
                    data: JSON.stringify(clsCompanyInsert),
                    success: function (data) {

                        clearallbox();
                        swal({
                            title: "Done",
                            text: "Employee info Succefully Updated",
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
                if (confirm("Are you really want to delete this Employee info?") == true) {
                    $.ajax({
                        headers: {
                            "Authorization": localStorage["access_token"]
                        },
                        url: url + "api/EmployeeDelete?company_id=" + company_id,
                        async: false,
                        method: 'Delete',
                        success: function (data) {
                            swal({
                                title: "Done",
                                text: "Employee info Succefully Deleted",
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
        });


        function clearallbox() {
            $('#txtcompany').val("");
            $('#txtusername').val("");
            $('#txtstdphone').val("");
            $('#txtemail').val("");
            $('#txtpassword').val("");
        }


        //showing Teacher info in table
        function showStdInfo() {
            $.ajax({
                headers: {
                    "Authorization": localStorage["access_token"]
                },
                url: url + "api/GetEmployee",
                async: false,
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    var voucherOptions = $('#tablerows');
                    voucherOptions.empty();
                    $(data).each(function (index, infostd) {
                        voucherOptions.append('<tr><td>' + (index + 1) + '</td> <td>' + infostd.name + '</td><td>' + infostd.username + '</td> <td>' + infostd.email + '</td><td id="' + infostd.password + '">*****</td><td>' + infostd.phone + '</td> <td><button type="button" class="btn btn-info editStdInfo" data-toggle="modal" data-target="#myModal" style="border-radius:0px;"  id="' + infostd.company_id + '"><i class="icon-pencil"></i></button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-danger delstdinfo" style="border-radius:0px;" id="' + infostd.company_id + '" ><i class="icon-trash"></i></button></td> </tr>');
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
                                <h4 class="page-title">Add Employees</h4>
                            </div>
                        </div>
                    </div>
                    <!-- end page title -->
                    <hr />
                    <button type="button" style="background: #1a2942;color:#ffffff" class="btn" id="btnAddstd" data-toggle="modal" data-target="#myModal">Add New Employee</button>
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body table-responsive">
                                    <table id="" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">

                                        <thead>
                                            <th style="width: 6%;">Sr#</th>
                                            <th>Employee name</th>
                                            <th>User Name</th>
                                            <th>E-mail</th>
                                            <th>Password</th>
                                            <th>Phone No</th>
                                            <th>Edit/Delete</th>
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
                        <h4 class="modal-title" id="insertHead"><strong>Add Employee Info</strong></h4>
                        <h4 class="modal-title" id="updateHead"><strong>Edit Employee Info</strong></h4>
                        <!--<button type="button" class="close pull-right" data-dismiss="modal" aria-hidden="true">×</button>-->
                    </div>
                    <div class="modal-body">
                        <form class="" action="#" autocomplete="off" method="post">

                            <div class="form-group">
                                <label for="fname">Employee name</label>
                                <input id="txtcompany" type="text" name="" placeholder="Enter Employee name" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="fname">User Name<span class="text-danger">*</span></label>
                                <input id="txtusername" type="text" name="" placeholder="Enter User Name" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="fname">E-mail<span class="text-danger">*</span></label>
                                <input id="txtemail" type="text" name="txtemail" placeholder="Enter E-mail" class="form-control" />
                            </div>
                             <div class="form-group">
                                <label for="fname">Password<span class="text-danger">*</span></label>
                                <input id="txtpassword" type="password" name="txtpassword" placeholder="Enter Password" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone No.<span class="text-danger">*</span></label>
                                <input id="txtstdphone" type="text" name="txtstdphone" placeholder="Enter phone no." class="form-control" />
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
    </div>
    <!-- sample modal content -->

    <!-- /.modal -->
    <!-- END wrapper -->
</asp:Content>
