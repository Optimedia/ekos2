<?php
	require_once 'SubjectManager.php';
	
	$subjectManager = new SubjectManager();
	
	$presentationID = $_SESSION['presentationID'];
	
	if( $presentationID != 0 ) {
		$subjectManager -> unlockPresentation( $presentationID );
	}

?>