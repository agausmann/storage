mm = 1;

epsilon = 0.1 * mm;

slot_offset = 20 * mm;
slot_length = 140 * mm;
slot_depth = 15 * mm;
slot_width = 2 * mm;

front_slot_depth = 5 * mm;
front_slot_width = 2 * mm;
front_slot_margin = 2 * mm;

card_spacing = 20 * mm;
num_cards = 8;

support_width = 4 * mm;
support_height = 6 * mm;

wall_width = 1 * mm;

module shell()
{
    translate([ -front_slot_margin, 0, 0 ]) cube([
        card_spacing * num_cards + wall_width + 2 * front_slot_margin,
        front_slot_width + 2 * wall_width,
        front_slot_depth,
    ]);

    for (i = [ 0.1, 0.4, 0.7, 1 ])
    {
        translate([ 0, slot_offset + slot_length * i + 2 * wall_width - support_width, 0 ])
        {
            cube([
                card_spacing * (num_cards - 1) + epsilon,
                wall_width,
                support_height,
            ]);
            cube([
                card_spacing * (num_cards - 1) + epsilon,
                support_width,
                wall_width,
            ]);
        }
    }
    for (i = [0:num_cards - 1])
    {
        translate([ card_spacing * i, slot_offset, 0 ]) cube([
            slot_width + 2 * wall_width,
            slot_length + 2 * wall_width,
            slot_depth,
        ]);
        translate([ card_spacing * i, 0, 0 ])
        {
            cube([ slot_width + 2 * wall_width, slot_length + 2 * wall_width + slot_offset, wall_width ]);
            cube([ wall_width, slot_length + 2 * wall_width + slot_offset, min(front_slot_depth, support_height) ]);
        }
    }
}

module pci_rack()
{
    difference()
    {
        shell();
        for (i = [0:num_cards - 1])
        {
            translate([ card_spacing * i + wall_width, slot_offset + wall_width, wall_width ]) cube([
                slot_width,
                slot_length,
                slot_depth + 2 * epsilon,
            ]);
        }
        translate([ wall_width - front_slot_margin, wall_width, -epsilon ]) cube([
            card_spacing * num_cards - wall_width + 2 * front_slot_margin,
            front_slot_width,
            front_slot_depth + 2 * epsilon,
        ]);
    }
}

pci_rack();
