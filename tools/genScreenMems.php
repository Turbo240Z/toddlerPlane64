<?php
    for($i=0;$i<25;$i++){
        echo "lda LVL_RAM+".($i*200).", x\n";
        echo "sta SCREENMEM+".($i*40).", y\n";
    }

    echo "\n";
    for($i=0;$i<25;$i++){
        echo "lda LVL_RAM+".($i*200).", x\n";
        echo "sta SCREENMEM2+".($i*40).", y\n";
    }


    echo "\n";
    for($i=0;$i<25;$i++){
        echo "ldy SCREENMEM+".($i*40).", x\n";
        echo "lda COLOR_MAP, y\n";
        echo "sta COLORMEM+".($i*40).", x\n";
    }

    echo "\n";
    for($i=0;$i<25;$i++){
        echo "ldy SCREENMEM2+".($i*40).", x\n";
        echo "lda COLOR_MAP, y\n";
        echo "sta COLORMEM+".($i*40).", x\n";
    }

?>
