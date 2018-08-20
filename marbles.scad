// 18mm wide
// 37mm long
// 5mm tall (assuming power soldered in)

// support: 8mm wide, 30mm long
// balls: 15.5mm diameter

// led: 5mm diameter, 8mm long

marble_diameter = 15.5;
marble_gap = marble_diameter/3;
marble_edge_offset = marble_diameter/6;
marbles = 6;

infinity = 1000;

box_width = marble_diameter;

led_diameter = 5;
led_length = 8;

cpu_length = 37;
cpu_width = 18;
cpu_depth = 5;

wall = 1;

marble_led_gap = 0.3;

$fn = 80;

difference() {
    union() {
        difference() {
            cube([
                wall*2 + marbles*marble_diameter + (marbles-1)*marble_gap + 2*marble_edge_offset, 
                box_width + 2*wall, 
                cpu_width+wall]);
            translate([wall, wall, -wall])
            cube([
                marbles*marble_diameter + (marbles-1)*marble_gap + 2*marble_edge_offset, 
                marble_diameter, 
                cpu_width + wall]);
        }
        for (i = [0:5]) {
            translate([
                wall + marble_edge_offset + marble_diameter/2 + (marble_diameter + marble_gap) * i,
                wall + box_width/2,
                cpu_width - led_length + (led_length + wall) / 2])
            cylinder(h=led_length + wall, d=led_diameter+wall*2, center=true);
        }
    }
    for (i = [0:5]) {
            translate([
                wall + marble_edge_offset + marble_diameter/2 + (marble_diameter + marble_gap) * i,
                wall + box_width/2,
                0]) {
                cylinder(h=infinity, d=led_diameter, center=true);
            
                //translate([0, 0, cpu_width+wall + 1*sqrt(pow(marble_diameter/2,2) - pow(led_diameter/2,2))])
                  #translate([0, 0, cpu_width + marble_diameter/2 + marble_led_gap])
                sphere(d=marble_diameter);
            }
    }
    
    translate([-wall/2, 1.66, (17.75-8)/2]) 
    cube([wall*2, 3, 8]);
}