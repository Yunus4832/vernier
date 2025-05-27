include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/masks.scad>
use <BOSL/shapes.scad>

// 模型精细度
$fn = 16;
ruler_max_length = 100;


// 游标卡尺刻度尺
module vernier_scale() {
    difference(){
        difference(){
            vernier_scale_base();
            base_scale(ruler_max_length - 12);
        }
        translate([8, -7.5, 0.5])
            slide_way(ruler_max_length - 7.9, 15.2, 0.8);
    }
}

// 游标卡尺刻度尺基底
module vernier_scale_base() {
    difference(){
        linear_extrude(height = 2)
            bottom_surface();
        up(2) right(5) xrot(-atan(2/10)) cube([6, 12, 5]);
    }
}

// 尺身刻度
// length: 刻度长度
module base_scale(length){
    translate([12, -15.1, 1.6])
    union(){
        union(){
            scale_array(10, 0.2, 5.1, 0.5, length);
            scale_array(5, 0.2, 3.1, 0.5, length);
        }
        scale_array(1, 0.2, 1.1, 0.5, length);
    }
    translate([11.5, -9, 1.6])
    scale_number_array(10, 2, 0.5, length);
    translate([11.5, -5, 1.6])
    scale_label(2, 0.5);
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

// 刻度数字序列
// interval: 间隔
// size: 字体大小
// thick: 厚度
// length: 总长
module scale_number_array(interval, size, thick, length){
    for(i = [0:length]) {
        if ( i % interval == 0 ){
            linear_extrude(height=thick)
            right(i) text(text = str(i / 10), size = size);
        }
    }
}

// 刻度标签
// size: 字体大小
// thick: 厚度
module scale_label(size, thick){
    linear_extrude(height=thick)
        text(text = "0.05 mm / cm", size = size);
}

// 底面
module bottom_surface(){
    bottom_surface_points = [
        [0, 0],
        [6, 0],
        [6, 10],
        [10, 5],
        [10, 0],
        [ruler_max_length, 0],
        [ruler_max_length, -15],
        [8, -15],
        [8, -20],
        [10, -20],
        [10, -42],
        [0, -22]
    ];
    polygon(points=bottom_surface_points);
}

// 滑轨
// length: 滑轨长度
module slide_way(length, width, thick){
    slide_way_side_points = [
        [0, 0],
        [0, -thick],
        [-thick, 0]
    ];
    yflip_copy(offset = width / 2)
    yrot(90)
    linear_extrude(height = length)
    polygon(points=slide_way_side_points);
}

vernier_scale();
