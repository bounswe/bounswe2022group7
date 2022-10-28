package com.group7.artshare.entity

import lombok.Data
import org.springframework.security.core.userdetails.UserDetails
import javax.persistence.*


@Data
@Entity
class RegisteredUser(

    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "accountInfo", referencedColumnName = "id")
    var accountInfo: AccountInfo,

    @ManyToMany(fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    @JoinTable(
        name = "user_authorities",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "authority_id")]
    )
    private val authorities: Set<Authority>
) : UserDetails
{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( nullable = false)
    var userId: Long = 0L

    @Column
    var isVerified: Boolean = false

    @Column
    var level: Int = 0

    @Column
    var xp: Double = 0.0

    @ManyToMany(mappedBy = "followers", cascade = [CascadeType.ALL])
    var following: Set<RegisteredUser> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var followers: Set<RegisteredUser> = HashSet()

    @ManyToMany(mappedBy = "blockedBy",cascade = [CascadeType.ALL])
    var blockedUsers: Set<RegisteredUser> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var blockedBy: Set<RegisteredUser> = HashSet()

    @Column
    var isBanned: Boolean = false

    @ManyToMany(cascade = [CascadeType.ALL])
    var allPhysicalExhibitions: Set<PhysicalExhibition> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var allOnlineGalleries: Set<OnlineGallery> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var bookmarkedArtItems: Set<ArtItem> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var bookmarkedPhysicalExhibitions: Set<PhysicalExhibition> = HashSet()

    @ManyToMany(cascade = [CascadeType.ALL])
    var bookmarkedOnlineGalleries: Set<OnlineGallery> = HashSet()

    //TODO discussion post
    //TODO past reply past posts
    //TODO read notifications
    //TODO unread notifications
    //TODO current bids

    override fun getAuthorities(): Set<Authority> {
        return authorities
    }
    override fun getPassword(): String {
        return accountInfo.getPassword()
    }

    override fun getUsername(): String {
        return accountInfo.username
    }

    override fun isAccountNonExpired(): Boolean {
        return true
    }

    override fun isAccountNonLocked(): Boolean {
        return true
    }

    override fun isCredentialsNonExpired(): Boolean {
        return true
    }

    override fun isEnabled(): Boolean {
        return true
    }

}