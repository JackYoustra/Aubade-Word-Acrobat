import java.awt.Component;


public class PhysicsBody {
	public final Component renderedItem;
	public Vector velocity;
	public PhysicsBody(Component renderedItem, Vector velocity) {
		super();
		this.renderedItem = renderedItem;
		this.velocity = velocity;
	}
}
