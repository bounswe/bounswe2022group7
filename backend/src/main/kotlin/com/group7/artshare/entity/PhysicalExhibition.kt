package com.group7.artshare.entity

import lombok.Data;
import javax.persistance.*;

@Data
@Entity
class PhysicalExhibition{

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "location")
    Location location;

    @Column
    List<String> rules;
}