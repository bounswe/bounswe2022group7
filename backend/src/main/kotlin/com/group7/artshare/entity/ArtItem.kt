
import com.fasterxml.jackson.annotation.JsonBackReference
import com.fasterxml.jackson.annotation.JsonManagedReference
import lombok.Data;
import java.util.*
import javax.persistence.*;

@Data
@Entity
class ArtItem{

    @Id
    @GeneratedValue
    var id: Long = 0L

    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "artItemInfo", referencedColumnName = "id")
    @JsonManagedReference
    var artItemInfo: ArtItemInfo? = null

    @ManyToOne(fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    @JoinColumn(name = "creator")
    var creator: Artist? = null

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var creationDate: Date = Calendar.getInstance().time

    @ManyToOne(fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    @JoinColumn(name = "owner")
    var owner: RegisteredUser? = null

    @Column
    var onAuction: Boolean = false

    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "auction", referencedColumnName = "id")
    @JsonManagedReference
    var auction: Auction? = null

    @Column
    var lastPrice: Double = 0.0;

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    var commentList: MutableSet<Comment> = mutableSetOf()

    @ManyToMany(mappedBy = "bookmarkedArtItems",cascade = [CascadeType.MERGE, CascadeType.PERSIST])
    @JsonBackReference
    var bookmarkedBy: MutableSet<RegisteredUser> = mutableSetOf()

}