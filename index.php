<?php include('header.php');?>

<div class="container">
    <div class="jumbotron">
        <img src="images/logo.png" height="100">
        
        <?php if(session_me()){ ?>
            <h2>Hello <?=ucfirst(strtolower($_SESSION['datauser']['tu_full_name']));?></h2>
            <p>Below is a summary of the total data contained in this application.</p>

            <br>
            <div class="row">
                <div class="col-md-2">
                    <label>DEPARTMENT</label><br>
                    <label><?=Q_count("SELECT * FROM tbl_department");?> data</label>
                </div>
                <div class="col-md-2">
                    <label>PRIORITY</label><br>
                    <label><?=Q_count("SELECT * FROM tbl_priority");?> data</label>
                </div>
                <div class="col-md-2">
                    <label>SERVICE</label><br>
                    <label><?=Q_count("SELECT * FROM tbl_service");?> data</label>
                </div>
                <div class="col-md-2">
                    <label>USER</label><br>
                    <label><?=Q_count("SELECT * FROM tbl_user WHERE tu_role!='admin'");?> data</label>
                </div>
                <div class="col-md-2">
                    <label>TICKET</label><br>
                    <label><?=Q_count("SELECT * FROM tbl_ticket");?> data</label>
                </div>
            </div>
        <?php } else { ?>
            <h2>Hello world!</h2>
            <p>Welcome to my application, there are many features that have been provided that you can use to help your current needs. Good luck, thank you.</p>
        <?php } ?>
    </div>
</div>

<?php include('footer.php');?>