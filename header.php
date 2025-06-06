<?php 
    session_start();
    require_once("func.php"); 
	
	$homeclass=""; $homesr="";
	$listclass=""; $listsr="";
	$openclass=""; $opensr="";
	$repoclass=""; $reposr="";
	$dataclass=""; $datasr="";
	if($page=="home") { $homeclass=" class=\"active\""; $homesr=" <span class=\"sr-only\">(current)</span>"; }
	elseif($page=="list") { $listclass=" class=\"active\""; $listsr=" <span class=\"sr-only\">(current)</span>"; }
	elseif($page=="open") { $openclass=" class=\"active\""; $opensr=" <span class=\"sr-only\">(current)</span>"; }
	elseif($page=="repo") { $repoclass=" class=\"active\""; $reposr=" <span class=\"sr-only\">(current)</span>"; }
	elseif($page=="data") { $dataclass=" active"; $datasr=" <span class=\"sr-only\">(current)</span>"; }
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title>Help Desk</title>
    <link rel="shortcut icon" href="images/icon.png">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-1.12.4.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <style type="text/css" media="print">
        @page 
        {
            size: auto;   /* auto is the current printer page size */
            margin: 0mm;  /* this affects the margin in the printer settings */
        }
        .print-hide{ display: none; }
        .print-header{ font-size: 15px; }
        .print-container{ font-size: 10px; }
    </style>
</head>

<?php 
    // if (session_status() !== PHP_SESSION_ACTIVE) {
    if(!session_me()){
        if(your_position() !== site_url(true)){
            redirect_to(site_url(true));
        }
        $userid = $_SERVER['HTTP_X_SANDSTORM_USER_ID'] ?? '';
        $displayname = urldecode($_SERVER['HTTP_X_SANDSTORM_USERNAME']);
        if (strpos($_SERVER['HTTP_X_SANDSTORM_PERMISSIONS'], "admin") !== false) { $rolelevel = "admin"; }
        elseif (strpos($_SERVER['HTTP_X_SANDSTORM_PERMISSIONS'], "tech") !== false) { $rolelevel = "tech"; }
        elseif (strpos($_SERVER['HTTP_X_SANDSTORM_PERMISSIONS'], "customer") !== false) { $rolelevel = "customer"; }
		
        if ($displayname != "Anonymous User")
        {
            $sql = "INSERT OR IGNORE INTO tbl_user (tu_role, tu_user, tu_full_name) VALUES ('$rolelevel', '$userid', '$displayname')";
            Q_execute($sql);
            $sql2 = "UPDATE tbl_user SET tu_role = '$rolelevel' WHERE tu_user='$userid'";
            Q_execute($sql2);
			
            $result = Q_array("SELECT * FROM tbl_user WHERE tu_user='$userid'");
            if(count($result) > 0){
                $_SESSION['login'] = true;
                $_SESSION['datauser'] = $result[0];
            }
        }
    }
?>

<body>
    <nav class="navbar navbar-inverse">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<?=site_url();?>">Help Desk</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li<?=$homeclass;?>><a href="/index.php">Home<?=$homesr;?></a></li>

                    <?php if(session_me()){ ?>

                        <li<?=$listclass;?>><a href="<?=site_url();?>/ticket-list.php">Ticket List<?=$listsr;?></a></li>
                        <li<?=$openclass;?>><a href="<?=site_url();?>/open-ticket.php">Open Ticket<?=$opensr;?></a></li>
                        <?php if ($_SESSION['datauser']['tu_role'] == 'tech' || $_SESSION['datauser']['tu_role'] == 'admin') { ?>
                            <li<?=$repoclass;?>><a href="<?=site_url();?>/reports.php">Reports<?=$reposr;?></a></li>
                            <li class="dropdown<?=$dataclass;?>">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Data<?=$datasr;?> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                <li><a href="<?=site_url();?>/department.php">Department</a></li>
                                <li><a href="<?=site_url();?>/priority.php">Priority</a></li>
                                <li><a href="<?=site_url();?>/service.php">Service</a></li>
                                <li><a href="<?=site_url();?>/users.php">Users</a></li>
                                </ul>
                            </li>
						<?php } ?>
                    <?php } ?>
                </ul>
                
                <ul class="nav navbar-nav">
                    
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>