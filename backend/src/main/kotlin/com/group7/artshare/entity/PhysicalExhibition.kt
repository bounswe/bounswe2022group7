package com.group7.artshare.entity

import lombok.Data;
import javax.persistence.*;

import java.util.*;


@Data
@Entity
class PhysicalExhibition{

    @Id
    @GeneratedValue
    val id: Long = 0L

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "location")
    val location: Location? = null;

    @Column
    val rules: String = ""
}