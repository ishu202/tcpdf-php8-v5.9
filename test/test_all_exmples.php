<?php
$cwd = getcwd();
$examplesPath = "$cwd/examples";
$files = scandir($examplesPath);
$excluded = ["index.php"];

foreach ($files as $file) {
    if (is_file("$examplesPath/$file") && !in_array($file, $excluded)) {
        $outfileName = basename($file , ".php");
        $output = "$cwd/output/$outfileName.pdf";
        $input = "$examplesPath/$file";

        if (file_exists($output)) {
            unlink($output);
        }

        echo shell_exec("$(which php) -f $input >> $output");
        printf("input file: %s output file: %s\n" , $input, $output);
    }
}