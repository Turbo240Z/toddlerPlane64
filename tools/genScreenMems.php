<?php
    for($i=0;$i<25;$i++){
        echo "lda LVL_RAM+".($i*200).", x\n";
        echo "sta SCREENMEM+".($i*40).", y\n";
    }
?>
