### Docker extensions

The **official** docker extensions mechanism will look a lot like Powerstrip.

Extensions will register themselves as interested in volumes or networking.

They will be called as **blocking pre-hooks** from Docker itself.