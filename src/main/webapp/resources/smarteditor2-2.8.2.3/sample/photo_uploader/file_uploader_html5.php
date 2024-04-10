<?php
 	$sFileInfo = '';
	$headers = array();
	 
	foreach($_SERVER as $k => $v) {
		if(substr($k, 0, 9) == "HTTP_FILE") {
			$k = substr(strtolower($k), 5);
			$headers[$k] = $v;
		} 
	}

	$filename = rawurldecode($headers['file_name']);
    // 파일 이름을 점(.)으로 분할하여 배열로 만듭니다.
    $file_parts = explode('.', $filename);

    // 배열에서 마지막 요소를 꺼내어 소문자로 변환합니다.
    $filename_ext = strtolower(array_pop($file_parts));

	$allow_file = array("jpg", "png", "bmp", "gif"); 

	if(!in_array($filename_ext, $allow_file)) {
		echo "NOTALLOW_".$filename;
	} else {
		$file = new stdClass;
		$file->name = date("YmdHis").mt_rand().".".$filename_ext;
		$file->content = file_get_contents("php://input");

		$uploadDir = '../../upload/';
		if(!is_dir($uploadDir)){
			mkdir($uploadDir, 0777);
		}
		
		$newPath = $uploadDir.$file->name;
		
		if(file_put_contents($newPath, $file->content)) {
			$sFileInfo .= "&bNewLine=true";
			$sFileInfo .= "&sFileName=".$filename;
			$sFileInfo .= "&sFileURL=upload/".$file->name;
		}
		
		echo $sFileInfo;
	}
?>