$(function() {

    moment.locale("id");
    var remote = $('#table_kategori').attr('data-remote');
    var target = $('#table_kategori').attr('data-target');
    var editKategori = $('#edit-kategori').find('#nama_kategori').attr('data-target'); //check nama_kategori
    var addKategori = $('#add-kategori').find('#nama_kategori').attr('data-target'); 
  
    var start = moment().subtract(29, 'days');
    var end = moment();

    $('.modal-content').css('border-radius', '10px');

    const Toast = Swal.mixin({
        toast: true,
        position: 'top-right',
        showConfirmButton: false,
        timer: 3000,
        animation: false,
        customClass: {
            popup: 'animated tada'
        },
    });

    function alertSuccess(msg) {
        Toast.fire({
            type: 'success',
            title: msg
        });
    }

    function alertWarning(msg) {
        Toast.fire({
            type: 'warning',
            title: msg
        });
    }

    function alertDanger(msg) {
        Toast.fire({
            type: 'error',
            title: msg
        });
    }

    function ajaxSuccess(id) {
        $(id)[0].reset();
        CloseModal().click();
        // problem nya ini. jadi harus di call
        a.resetForm();
    }
    
    const CloseModal = () => $('[data-dismiss=modal]').on('click', function (e) {
        e.preventDefault();

        const $t = $(this), target = $t[0].href || $t.data("target") || $t.parents('.modal') || [];
        
        $(target).find('.form-group').attr('class', 'form-group');
        $(target).find('span.form-control-feedback').remove();
        $(target).find('em.has-error').remove();
        $(target).find('div.has-feedback').removeClass('has-feedback');
        $(target).find('input').attr('class', 'form-control').removeAttr('aria-describedby').removeAttr('aria-invalid');
        $(target).find('select').attr('class', 'form-control custom-select custom-select-sm');
        $(target).find('.custom-file-label').empty();
        $(target)
            .find("input,textarea,select").val('').removeClass('is-valid').removeClass('is-invalid').end()
            .find("input[type=file]").val('').removeClass('is-valid').removeClass('is-invalid').end()
            .find("input[type=checkbox], input[type=radio]").prop("checked", "").removeClass('is-valid').removeClass('is-invalid').end();
        let timeoutHandler = null;
        if (document.getElementsByClassName('custom-file-label').length > 0) 
            $('.custom-file-label')[0].innerText = "File";

        $('.modal').on('hide.bs.modal', () => {
            $('.modal-dialog').removeClass('zoomIn').addClass('zoomOut');
            
            if (timeoutHandler) 
                clearTimeout(timeoutHandler);
            
            timeoutHandler = setTimeout(() => {
                $('.modal-dialog').removeClass('zoomOut').addClass('zoomIn');
            }, 1000);
        });
    });

    CloseModal();

    const a = $('#add-kategori').validate({
        errorClass: 'has-error animated tada',
        validClass: 'has-success',
        rules: {
            nama_kategori: {
                required: true,
                remote: {
                    url: http + 'fetch?f='+remote+'&d='+addKategori,
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        nama_kategori: function() {
                            return $('#add-kategori').find("#nama_kategori" ).val();
                        }
                    },
                    
                }
            },
          
        }, messages: {
            nama_kategori: {
                required: "Nama kategori harus diisi !",
                remote: "Nama kategori telah digunakan !"
            }
        },
        
        
        errorElement: "em",
        errorPlacement: function ( error, element ) {
            error.addClass("help-block");
            element.parents(".col-xs-9").addClass("has-feedback");

            if (element.prop( "type" ) === "checkbox") {
                error.insertAfter( element.parent("label"));
            } else {
                error.insertAfter( element);
            }
            if (!element.next( "span" )[ 0 ] ) {
                $( "<span class='glyphicon glyphicon-remove form-control-feedback'></span>").insertAfter(element);
            }
        },
        highlight: function(element, errorClass, validClass) {
            $(element).closest('.form-group').addClass(errorClass).removeClass(validClass);
            $(element).next("span").addClass("glyphicon-remove").removeClass("glyphicon-ok");
        },
        unhighlight: function(element, errorClass, validClass) {
            $(element).closest('.form-group').addClass(validClass).removeClass(errorClass);
            $(element).next("span").addClass("glyphicon-ok").removeClass("glyphicon-remove");
        },
        submitHandler: function(form) {
            var route = $('#add-kategori').attr('data-target'); //store_user
            var kategori = new FormData($('#add-kategori')[0]);
            // console.log($('#add-kategori')[0]);
            $.ajax({
                url: http + 'fetch?f='+remote+'&d='+route,
                type: 'POST',
                async: true,
                cache: false,
                dataType: 'json',
                processData: false,
                contentType: false,
                timeout: 3000,
                data: kategori,
                beforeSend: function() {
                    showLoading();
                },
                success: function(res) {
                    hideLoading();

                    if (res.length == 0) {
                        dataTable.ajax.reload();
                        alertDanger('Invalid request');
                    } else {
                        if (res.kategori.code == 1) {
                            ajaxSuccess('#add-kategori');
                            dataTable.ajax.reload();
                            alertSuccess(res.kategori.message);
                            
                        } else {
                            dataTable.ajax.reload();
                            alertWarning(res.kategori.message);
                        }
                    }
                },
                error: function(jqXHR, status, error) {
                    hideLoading();
                    alertDanger(status);
                    location.reload();
                }
            });
            return false;
        }
    });

    $('#edit-kategori').validate({
        errorClass: 'has-error animated tada',
        validClass: 'has-success',
        rules: {
            nama_kategori: {
                required: false,
                remote: {
                    url: http + 'fetch?f='+remote+'&d='+editKategori,
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        id: function() { 
                            return $('#edit-kategori').find('input[type=hidden]').val();
                        },
                        nama_kategori: function() {
                            return $('#edit-kategori').find("#nama_kategori" ).val();
                        }
                    }
                }
            }
        },
        messages: {
            nama_kategori: {
                required: "Nama Kategori harus diisi !",
                remote: "Nama Kategori telah digunakan !"
            },
        },
        errorElement: "em",
        errorPlacement: function (error, element) {
            error.addClass("help-block");
            element.parents(".col-xs-9").addClass("has-feedback");

            if (element.prop( "type" ) === "checkbox") {
                error.insertAfter( element.parent("label"));
            } else {
                error.insertAfter( element);
            }
            if (!element.next( "span" )[ 0 ]) {
                $( "<span class='glyphicon glyphicon-remove form-control-feedback'></span>").insertAfter(element);
            }
        },
        highlight: function(element, errorClass, validClass) {
            $(element).closest('.form-group').addClass(errorClass).removeClass(validClass);
            $(element).next("span").addClass("glyphicon-remove").removeClass("glyphicon-ok");
        },
        unhighlight: function(element, errorClass, validClass) {
            $(element).closest('.form-group').addClass(validClass).removeClass(errorClass);
            $(element).next("span").addClass("glyphicon-ok").removeClass("glyphicon-remove");
        },
        submitHandler: function(form) {
            var route = $('#edit-kategori').attr('data-target');
            var kategori = new FormData($('#edit-kategori')[0]);
            var id = $('#edit-kategori').find('input[type=hidden]').val();
            $.ajax({
                url: http + 'fetch?f='+remote+'&d='+route+'&id='+id,
                type: 'POST',
                async: true,
                cache: false,
                dataType: 'json',
                processData: false,
                contentType: false,
                timeout: 3000,
                data: kategori,
                beforeSend: function() {
                    showLoading();
                },
                success: function(res) {
                    
                    if (res.length == 0) {
                        hideLoading();
                        alertDanger('Invalid request');
                    } else {
                        if (res.kategori.code == 1) {
                            ajaxSuccess('#edit-kategori');
                            dataTable.ajax.reload();
                            hideLoading();
                            alertSuccess(res.kategori.message);
                        } else {
                            hideLoading();
                            alertWarning(res.kategori.message);
                        }
                    }
                },
                error: function(jqXHR, status, error) {
                    hideLoading();
                    alertDanger(error);
                }
            });
            return false;
        }
    });
    $("#table_kategori").on('click', '#edit', function (e) {
        e.preventDefault();
        var route = $(this).attr('data-target');
        var id = $(this).attr('data-content');
        $a = $('#edit-kategori').find('input[type=hidden],input[type=text], select, textarea');
        $.ajax({
            url: http + 'fetch?f='+remote+'&d='+route+'&id='+id,
            type: 'GET',
            async: true,
            dataType: 'json',
            beforeSend: function () {
                showLoading();
            },
            success: function (res) {
                if (res.length == 0) {
                    hideLoading();
                    alertDanger('Invalid request');
                } else {
                    if (res.kategori.code == 1) {
                        hideLoading();
                        $('#editModal').modal({
                            'show': true,
                            'backdrop': 'static'
                        });
                        for (let i = 0; i < $a.length; i++) {
                            $a.eq(i).val(res.kategori.data[i]);
                        }
                    } else {
                        hideLoading();
                        alertWarning(res.kategori.message);
                    }
                }
            },
            error: function (jqXHR, status, error) {
                hideLoading();
                alertDanger(status);
                
            }
        });
    });
    $("#table_kategori").on('click', '#hapus', function (e) {
        e.preventDefault();
        var nm = $(this).attr('title-content');
        var route = $(this).attr('data-target');
        var id = $(this).attr('data-content');
        Swal.fire({
            title: 'Apa Anda Yakin?',
            html: 'Menghapus data kategori <b>' + nm + '</b> ?',
            type: 'warning',
            showCancelButton: true,
            allowOutsideClick: false,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Ya',
            cancelButtonText: 'Tidak'
        }).then(function (isConfirm) {
            if (isConfirm.value) {
                $.ajax({
                    url: http + 'fetch?f='+remote+'&d='+route+'&id='+id,
                    type: 'POST',
                    dataType: 'json',
                    async: true,
                    processData: false,
                    contentType: false,
                    beforeSend: function () {
                        showLoading();
                    },
                    success: function (res) {
                        if (res.length == 0) {
                            hideLoading();
                            alertDanger('Invalid request');
                        } else {
                            if (res.kategori.code == 1) {
                                hideLoading();
                                dataTable.ajax.reload();
                                alertSuccess(res.kategori.message);
                            } else {
                                hideLoading();
                                alertWarning(res.kategori.message);
                            }
                        }
                    },
                    error: function (jqXHR, status, error) {
                        hideLoading();
                        alertDanger(status);
                    }
                });
            }
        });
    });
    
     //
    var dataTable = $("#table_kategori").DataTable({
        "language": {
            "sEmptyTable":   "Tidak ada data yang tersedia pada tabel ini",
            "sProcessing":   "Sedang memproses...",
            "sLengthMenu":   "Tampilkan _MENU_ entri",
            "sZeroRecords":  "Tidak ditemukan data yang sesuai",
            "sInfo":         "Menampilkan _START_ sampai _END_ dari _TOTAL_ entri",
            "sInfoEmpty":    "Menampilkan 0 sampai 0 dari 0 entri",
            "sInfoFiltered": "(disaring dari _MAX_ entri keseluruhan)",
            "sInfoPostFix":  "",
            "sSearch":       "Cari:",
            "sUrl":          "",
            "oPaginate": {
                "sFirst":    "Pertama",
                "sPrevious": "Sebelumnya",
                "sNext":     "Selanjutnya",
                "sLast":     "Terakhir"
            }
        },
        //"scrollY": true,
        "fixedHeader": true,
        "fixedColumns": true,
        //"autoWidth": true,
        "processing": true,
        "serverSide": true,
        "ajax": {
            url: http + 'fetch?f='+remote+'&d='+target,
            type: "POST",
            dataType: 'json',
            // data: 'dataTable',
            beforeSend: function () {
                $("#table_kategori_processing").addClass("text-center").html('<i class="fa fa-spinner fa-pulse fa-fw text-blue"></i>&nbsp;<span>Memuat Data...</span>');
                //console.log(data); pake debug nilai
            },
            error: function () {
                $(".table_kategori-error").html("");
                $("#table_kategori").append('<tbody class="table_kategori-error"><tr><td colspan="7" class="text-center">Tidak ada data</td></tr></tbody>');
                $("#table_kategori_processing").css('display', 'none');
            }
        },
        "pageLength": 10,
        "order": [
            [0,"desc"]
        ],
        columnDefs: [
            {
                orderable: true,
                targets: [0,1]
            },
            {
                orderable: false,
                targets: [2]
            },
            {
                searchable: true,
                targets: [1]
            },
            {
                searchable: false,
                targets: [0,2]
            }
        ],
        "lengthMenu": [
            [5, 10, 25, 50, 100, -1],
            [5, 10, 25, 50, 100, "Semua"]
        ]
        
    });
    
    $("#table_kategori_filter").addClass("pull-right");
    $("#table_kategori_paginate").addClass("pull-right");
    
    dataTable.on("draw.dt", function () {
        var info = dataTable.page.info();
        dataTable.column(0, {
            search: "applied",
            order: "applied",
            page: "applied"
        }).nodes().each(function (cell, i) {
            cell.innerHTML = i + 1 + info.start + ".";
        });
    });
  
    jQuery.noConflict();

    $("#create_kategori").on('click', function (e) {
        e.preventDefault();
        $('#addModal').modal({
            'show': true,
            'backdrop': 'static'
        });
    });   
    
    $('#filter').on('click change', function() {
        $a = $(this);
        if ($a.val() == 3) {
            $('#range').prop('disabled',false).focus();
        } else {
            $('#range').val('').attr('disabled',true).closest('.form-group').removeClass('has-success');
        }
    });
    
    $('#range').daterangepicker({
        locale: {
            format: "DD/MM/YYYY"
        },
        showDropdowns: true,
        autoApply: true,
        startDate: start,
        endDate: end,
        maxDate: end,
        opens: "center",
        drops: "down",
      }, function(start, end, label) {
        //console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
    });
});