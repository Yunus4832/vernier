include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/masks.scad>
use <BOSL/shapes.scad>

// 模型精细度
$fn = 16;

// 游标卡尺游标
module vernier_cursor(){
    difference(){
        difference() {
            difference(){
                difference(){
                    vernier_cursor_base();
                    scale_slot(60);
                }
                up(3) cube([20, 20, 6], center=true);
            }
            cursor_scale(19);
        }
        translate([26, -20, 0])
            fillet_mask_z(l=6, r=1);
    }
}

// 游标卡尺游标基底
module vernier_cursor_base(){
    down(1)
    linear_extrude(height = 3)
        bottom_surface();
}

// 底面
module bottom_surface(){
    bottom_surface_points = [
        [10, -42],
        [10, -5],
        [2, -5],
        [2, 0],
        [6, 10],
        [6, 2],
        [36, 2],
        [36, -20],
        [26, -20],
        [26, -18],
        [16, -18],
        [12, -42]
    ];
    polygon(points=bottom_surface_points);
}

// 游标刻度
module cursor_scale(length){
    translate([12, -14.9, 1.6])
    yflip()
    union(){
        union(){
            scale_array(9.5, 0.2, 3, 0.5, length);
            scale_array(4.75, 0.2, 2, 0.5, length);
        }
        scale_array(0.95, 0.2, 1, 0.5, length);
    }
}

// 刻度阵列
// span: 刻度间隔
// thick: 刻度厚度
// w: 刻度宽度
// h: 刻度高度
// length: 刻度总长
module scale_array(interval, thick, w, h, length){
    for (i = [0:interval:length]){
        right(i) cube([thick, w, h]);
    }
}

// 刻度尺槽
module scale_slot(length){
    slot_side_points = [
        [0, 0],
        [-0.5, 0],
        [-0.85, -0.35],
        [-1.2, 0],
        [-3, 0],
        [-3, -15],
        [-1.2, -15],
        [-0.85, -14.65],
        [-0.5, -15],
        [0, -15]
    ];
    yrot(90)
    linear_extrude(height = length)
    polygon(points=slot_side_points);
}

// 刻度数字序列
// interval: 间隔
// size: 字体大小
// thick: 厚度
// length: 总长
module scale_number_array(interval, size, thick, length){
    for(i = [0:interval:length]) {
        linear_extrude(height=thick)
            right(i) text(text = str(i / 10), size = size);
    }
}

vernier_cursor();
