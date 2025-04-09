<?php include('header.php');?>

<div class="container">
    <div class="jumbotron">
        <img src="images/logo.png" height="100">
        
        <?php if(session_me()){ ?>
            <h2>Hello <?=$_SESSION['datauser']['tu_full_name'];?></h2>
            <p>Ticket status summary:</p>

            <br>
            <div class="row">
                <div class="col-md-2">
                    <label>OPEN</label><br>
                    <label><?=Q_count("SELECT * FROM tbl_ticket WHERE tt_status = 'NEW'");?> tickets</label>
                </div>
                <div class="col-md-2">
                    <label>PENDING</label><br>
                    <label><?=Q_count("SELECT * FROM tbl_ticket WHERE tt_status = 'PENDING'");?> tickets</label>
                </div>
                <div class="col-md-2">
                    <label>TOTAL</label><br>
                    <label><?=Q_count("SELECT * FROM tbl_ticket");?> tickets</label>
                </div>
                <div class="col-md-2">
                    <label>USER</label><br>
                    <label><?=Q_count("SELECT * FROM tbl_user");?> users</label>
                </div>
            </div>
        <?php } else { ?>
            <h2>Welcome to the Help Desk</h2>
            <p>Please sign in to create a help desk ticket.</p>
        <?php } ?>
    </div>
</div>

<?php include('footer.php');?>